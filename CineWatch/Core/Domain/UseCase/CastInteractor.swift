//
//  CastInteractor.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine

protocol CastUseCase {
    func getCast(movieId: Int) -> AnyPublisher<[CastModel], Error>
}

class CastInteractor: CastUseCase {
    private let repository: CastRepositoryProtocol

    required init(repository: CastRepositoryProtocol) {
        self.repository = repository
    }

    func getCast(movieId: Int) -> AnyPublisher<[CastModel], Error> {
        return repository.getCast(movieId: movieId)
    }
}
