//
//  CastInteractor.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine

public protocol CastUseCase {
    func getCast(movieId: Int) -> AnyPublisher<[CastModel], Error>
}

public class CastInteractor: CastUseCase {
    private let repository: CastRepositoryProtocol

    public required init(repository: CastRepositoryProtocol) {
        self.repository = repository
    }

    public func getCast(movieId: Int) -> AnyPublisher<[CastModel], Error> {
        return repository.getCast(movieId: movieId)
    }
}
