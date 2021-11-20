//
//  CastRepository.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine

public protocol CastRepositoryProtocol {
    func getCast(movieId: Int) -> AnyPublisher<[CastModel], Error>
}

public final class CastRepository: NSObject {
    public typealias CastInstance = (CastDataSource) -> CastRepository

    fileprivate let remote: CastDataSource

    private init(remote: CastDataSource) {
        self.remote = remote
    }

    public static let sharedInstance: CastInstance = { remoteRepo in
        return CastRepository(remote: remoteRepo)
    }
}

extension CastRepository: CastRepositoryProtocol {
    public func getCast(movieId: Int) -> AnyPublisher<[CastModel], Error> {
        return self.remote.getCast(movieId: movieId)
            .map { CastMapper.mapCastResponsesToDomains(input: $0) }
                    .eraseToAnyPublisher()
    }
}
