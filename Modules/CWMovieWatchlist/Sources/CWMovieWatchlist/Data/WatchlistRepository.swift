//
//  File.swift
//  
//
//  Created by Andika on 09/11/21.
//

import Foundation
import Combine

public protocol WatchlistRepositoryProtocol {
    func getWatchlist() -> AnyPublisher<[WatchlistModel], Error>
    func addToWatchlist(movie: WatchlistModel) -> AnyPublisher<Bool, Error>
    func removeFromWatchlist(movie: WatchlistModel) -> AnyPublisher<Bool, Error>
    func isMovieOnWatchlist(movie: WatchlistModel) -> AnyPublisher<Bool, Error>

    func clearWatchlist() -> AnyPublisher<Bool, Error>
}

public final class WatchlistRepository: NSObject {
    public typealias WatchlistInstance = (WatchlistDataSource) -> WatchlistRepository

    fileprivate let local: WatchlistDataSource

    private init(local: WatchlistDataSource) {
        self.local = local
    }

    public static let shared: WatchlistInstance = { local in
        return WatchlistRepository(local: local)
    }
}

extension WatchlistRepository: WatchlistRepositoryProtocol {
    public func getWatchlist() -> AnyPublisher<[WatchlistModel], Error> {
        return self.local.getWatchlist()
            .map { WatchlistMapper.mapMovieEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }

    public func addToWatchlist(movie: WatchlistModel) -> AnyPublisher<Bool, Error> {
        return self.local.addToWatchlist(movie: WatchlistMapper.mapMovieDomainsToEntities(input: movie))
            .eraseToAnyPublisher()
    }

    public func removeFromWatchlist(movie: WatchlistModel) -> AnyPublisher<Bool, Error> {
        return self.local.removeFromWatchlist(movie: WatchlistMapper.mapMovieDomainsToEntities(input: movie))
            .eraseToAnyPublisher()
    }

    public func isMovieOnWatchlist(movie: WatchlistModel) -> AnyPublisher<Bool, Error> {
        return self.local.isMovieOnWatchlist(movie: WatchlistMapper.mapMovieDomainsToEntities(input: movie))
            .eraseToAnyPublisher()
    }

    public func clearWatchlist() -> AnyPublisher<Bool, Error> {
        return self.local.clearWatchlist()
            .eraseToAnyPublisher()
    }
}
