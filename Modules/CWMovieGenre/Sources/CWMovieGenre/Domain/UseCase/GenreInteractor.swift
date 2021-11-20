//
//  GenreInteractor.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine

public protocol GenreUseCase {
    func getGenre() -> AnyPublisher<[GenreModel], Error>
}

public class GenreInteractor: GenreUseCase {
    private let repository: GenreRepositoryProtocol

    public required init(repository: GenreRepositoryProtocol) {
        self.repository = repository
    }

    public func getGenre() -> AnyPublisher<[GenreModel], Error> {
        return repository.getGenre()
    }
}
