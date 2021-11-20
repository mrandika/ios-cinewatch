//
//  DiscoveryInteractor.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine

public protocol DiscoverUseCase {
    func getDiscover(genre: Int?, page: Int) -> AnyPublisher<[MovieModel], Error>
}

public class DiscoverInteractor: DiscoverUseCase {
    private let repository: MovieRepositoryProtocol

    public required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    public func getDiscover(genre: Int?, page: Int) -> AnyPublisher<[MovieModel], Error> {
        return repository.getDiscover(genre: genre, page: page)
    }
}
