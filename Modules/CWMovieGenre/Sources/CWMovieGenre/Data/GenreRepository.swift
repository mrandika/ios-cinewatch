//
//  GenreRepository.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine

public protocol GenreRepositoryProtocol {
    func getGenre() -> AnyPublisher<[GenreModel], Error>
}

public final class GenreRepository: NSObject {
    public typealias GenreInstance = (GenreDataSource) -> GenreRepository

    fileprivate let remote: GenreDataSource

    private init(remote: GenreDataSource) {
        self.remote = remote
    }

    public static let sharedInstance: GenreInstance = { remoteRepo in
        return GenreRepository(remote: remoteRepo)
    }
}

extension GenreRepository: GenreRepositoryProtocol {
    public func getGenre() -> AnyPublisher<[GenreModel], Error> {
        return self.remote.getGenre()
            .map { GenreMapper.mapGenreResponsesToDomains(input: $0) }
                    .eraseToAnyPublisher()
    }
}
