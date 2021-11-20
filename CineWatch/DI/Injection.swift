//
//  Injection.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import Foundation

import CWMovie
import CWMovieDetail
import CWMovieWatchlist
import CWMovieGenre

final class Injection: NSObject {
    private let movieInjection = MovieInjection()
    private let movieDetailInjection = MovieDetailInjection()
    private let movieWatchlistInjection = MovieWatchlistInjection()
    private let castInjection = CastInjection()
    private let genreInjection = GenreInjection()

    func provideDiscover() -> DiscoverUseCase {
        return movieInjection.provideDiscover()
    }

    func provideNowPlaying() -> NowPlayingUseCase {
        return movieInjection.provideNowPlaying()
    }

    func provideUpcoming() -> UpcomingUseCase {
        return movieInjection.provideUpcoming()
    }

    func provideWatchlist() -> WatchlistUseCase {
        return movieWatchlistInjection.provideWatchlist()
    }

    func providePopular() -> PopularUseCase {
        return movieInjection.providePopular()
    }

    func provideSearch() -> SearchUseCase {
        return movieInjection.provideSearch()
    }

    func provideDetail() -> DetailUseCase {
        return movieDetailInjection.provideDetail()
    }

    func provideCast() -> CastUseCase {
        return castInjection.provideCast()
    }

    func provideGenre() -> GenreUseCase {
        return genreInjection.provideGenre()
    }
}
