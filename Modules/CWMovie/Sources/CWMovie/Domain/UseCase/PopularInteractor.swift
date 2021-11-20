//
//  PopularInteractor.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine

public protocol PopularUseCase {
    func getPopular(page: Int) -> AnyPublisher<[MovieModel], Error>
}

public class PopularInteractor: PopularUseCase {
    private let repository: MovieRepositoryProtocol

    public required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    public func getPopular(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return repository.getPopular(page: page)
    }
}
