//
//  Injection.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import Foundation

public final class MovieInjection: NSObject {
    private func provideMovieRepository() -> MovieRepositoryProtocol {
        let remote: MovieDataSource = MovieDataSource.shared

        return MovieRepository.shared(remote)
    }

    public func provideDiscover() -> DiscoverUseCase {
        let repository = provideMovieRepository()
        return DiscoverInteractor(repository: repository)
    }

    public func provideNowPlaying() -> NowPlayingUseCase {
        let repository = provideMovieRepository()
        return NowPlayingInteractor(repository: repository)
    }

    public func provideUpcoming() -> UpcomingUseCase {
        let repository = provideMovieRepository()
        return UpcomingInteractor(repository: repository)
    }

    public func providePopular() -> PopularUseCase {
        let repository = provideMovieRepository()
        return PopularInteractor(repository: repository)
    }

    public func provideSearch() -> SearchUseCase {
        let repository = provideMovieRepository()
        return SearchInteractor(repository: repository)
    }
}
