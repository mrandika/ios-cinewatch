//
//  CineWatchApp.swift
//  CineWatch
//
//  Created by Andika on 21/10/21.
//

import SwiftUI

import CWMovie
import CWMovieWatchlist

import CWMoviePage
import CWDetailPage
import CWGenrePage

@main
struct CineWatchApp: App {
    var body: some Scene {
        let injection = Injection.init()
        let watchlist = injection.provideWatchlist()

        let discoveryPresenter = DiscoverPresenter(discoverUseCase: injection.provideDiscover())
        let nowPlayingPresenter = NowPlayingPresenter(nowPlayingUseCase: injection.provideNowPlaying())
        let upcomingPresenter = UpcomingPresenter(upcomingUseCase: injection.provideUpcoming())
        let watchlistPresenter = WatchlistPresenter(watchlistUseCase: watchlist)
        let detailWatchlistPresenter = DetailWatchlistPresenter(watchlistUseCase: watchlist)
        let popularPresenter = PopularPresenter(popularUseCase: injection.providePopular())
        let searchPresenter = SearchPresenter(searchUseCase: injection.provideSearch())
        let genrePresenter = GenrePresenter(genreUseCase: injection.provideGenre())

        let appState = AppState()

        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(discoveryPresenter)
                .environmentObject(nowPlayingPresenter)
                .environmentObject(upcomingPresenter)
                .environmentObject(watchlistPresenter)
                .environmentObject(detailWatchlistPresenter)
                .environmentObject(popularPresenter)
                .environmentObject(searchPresenter)
                .environmentObject(genrePresenter)
        }
    }
}
