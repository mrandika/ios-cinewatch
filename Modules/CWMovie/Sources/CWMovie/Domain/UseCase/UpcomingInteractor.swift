//
//  UpcomingInteractor.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine

public protocol UpcomingUseCase {
    func getUpcoming(page: Int) -> AnyPublisher<[MovieModel], Error>
}

public class UpcomingInteractor: UpcomingUseCase {
    private let repository: MovieRepositoryProtocol

    public required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    public func getUpcoming(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return repository.getUpcoming(page: page)
    }
}
