//
//  DetailInteractor.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine

public protocol DetailUseCase {
    func getDetail(id: Int) -> AnyPublisher<MovieDetailModel, Error>
}

class DetailInteractor: DetailUseCase {
    private let repository: MovieDetailRepositoryProtocol

    required init(repository: MovieDetailRepositoryProtocol) {
        self.repository = repository
    }

    func getDetail(id: Int) -> AnyPublisher<MovieDetailModel, Error> {
        return repository.getDetail(id: id)
    }
}
