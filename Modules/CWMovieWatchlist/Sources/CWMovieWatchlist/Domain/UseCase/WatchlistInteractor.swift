//
//  WatchlistInteractor.swift
//  CineWatch
//
//  Created by Andika on 29/10/21.
//

import Foundation
import Combine

public protocol WatchlistUseCase {
    func getWatchlist() -> AnyPublisher<[WatchlistModel], Error>
    func addToWatchlist(movie: WatchlistModel) -> AnyPublisher<Bool, Error>
    func removeFromWatchlist(movie: WatchlistModel) -> AnyPublisher<Bool, Error>
    func isMovieOnWatchlist(movie: WatchlistModel) -> AnyPublisher<Bool, Error>

    func clearWatchlist() -> AnyPublisher<Bool, Error>
}

public class WatchlistInteractor: WatchlistUseCase {
    private let repository: WatchlistRepositoryProtocol

    public required init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    public func getWatchlist() -> AnyPublisher<[WatchlistModel], Error> {
        return repository.getWatchlist()
    }

    public func addToWatchlist(movie: WatchlistModel) -> AnyPublisher<Bool, Error> {
        return repository.addToWatchlist(movie: movie)
    }

    public func removeFromWatchlist(movie: WatchlistModel) -> AnyPublisher<Bool, Error> {
        return repository.removeFromWatchlist(movie: movie)
    }

    public func isMovieOnWatchlist(movie: WatchlistModel) -> AnyPublisher<Bool, Error> {
        return repository.isMovieOnWatchlist(movie: movie)
    }

    public func clearWatchlist() -> AnyPublisher<Bool, Error> {
        return repository.clearWatchlist()
    }
}
