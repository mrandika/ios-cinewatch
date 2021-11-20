//
//  SearchInteractor.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine

public protocol SearchUseCase {
    func search(query: String) -> AnyPublisher<[MovieModel], Error>
}

public class SearchInteractor: SearchUseCase {
    private let repository: MovieRepositoryProtocol

    public required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    public func search(query: String) -> AnyPublisher<[MovieModel], Error> {
        return repository.search(query: query)
    }
}
