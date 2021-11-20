//
//  NowPlayingInteractor.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import Foundation
import Combine

public protocol NowPlayingUseCase {
    func getNowPlaying(page: Int) -> AnyPublisher<[MovieModel], Error>
}

public class NowPlayingInteractor: NowPlayingUseCase {
    private let repository: MovieRepositoryProtocol

    public required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    public func getNowPlaying(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return repository.getNowPlaying(page: page)
    }
}
