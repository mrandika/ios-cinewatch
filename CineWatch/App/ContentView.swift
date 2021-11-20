//
//  ContentView.swift
//  CineWatch
//
//  Created by Andika on 21/10/21.
//

import SwiftUI

import CWMoviePage
import CWGenrePage

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    // AccountSheet-relaated
    @EnvironmentObject var genrePresenter: GenrePresenter
    @EnvironmentObject var discoverPresenter: DiscoverPresenter
    @EnvironmentObject var watchlistPresenter: WatchlistPresenter

    @State var tabSelection: TabItems = .discover

    var body: some View {
        TabView(selection: $tabSelection) {
            DiscoverView().tabItem {
                Image(systemName: tabSelection == .discover ? "newspaper.fill" : "newspaper")
                Text("DISCOVER")
            }.tag(TabItems.discover)

            NowPlayingView().tabItem {
                Image(systemName: tabSelection == .nowPlaying ? "play.tv.fill" : "play.tv")
                Text("NOW_PLAYING")
            }.tag(TabItems.nowPlaying)

            UpcomingView().tabItem {
                Image(systemName: "calendar.badge.clock")
                Text("UPCOMING")
            }.tag(TabItems.upcoming)

            SearchView(accountSheet: {
                /*
                 This view requires a GenrePresenter because if the sheet
                 not closed completely (dragged halfway), its causing EnvironmentObject reseted to nil.
                 */
                AccountView()
                    .environmentObject(genrePresenter)
                    .environmentObject(discoverPresenter)
                    .environmentObject(watchlistPresenter)
            }).tabItem {
                Image(systemName: "magnifyingglass")
                Text("SEARCH")
            }.tag(TabItems.search)
        }.accentColor(Color(UIColor.systemRed))
            .sheet(isPresented: $appState.passedOnBoarding, onDismiss: {
                appState.passOnboarding()
            }, content: {
                OnboardingView()
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let injection = Injection.init()

        let genrePresenter = GenrePresenter(genreUseCase: injection.provideGenre())
        let discoverPresenter = DiscoverPresenter(discoverUseCase: injection.provideDiscover())
        let watchlistPresenter = WatchlistPresenter(watchlistUseCase: injection.provideWatchlist())

        ContentView()
            .environmentObject(AppState())
            .environmentObject(genrePresenter)
            .environmentObject(discoverPresenter)
            .environmentObject(watchlistPresenter)
    }
}
