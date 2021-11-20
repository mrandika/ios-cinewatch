//
//  WatchlistView.swift
//  CineWatch
//
//  Created by Andika on 29/10/21.
//

import SwiftUI

import CWCommon
import CWSharedView
import CWMovieWatchlist

public struct WatchlistView: View {
    @EnvironmentObject var presenter: WatchlistPresenter

    public init() {}

    public var body: some View {
        VStack {
            if presenter.movies.isEmpty {
                ErrorState(image: "State_Empty",
                           error: DataError.dataEmpty(),
                           showRetryButton: false,
                           retryAction: {
                    // Do nothing
                })
            } else {
                StateContainer(isLoading: $presenter.isLoading,
                               isError: $presenter.isError,
                               error: presenter.error, content: {
                    ScrollView {
                        LazyVStack {
                            ForEach(presenter.movies, id: \.id) { movie in
                                presenter.navigationLinkBuilder(movie: movie, content: {
                                    MoviePoster(movie: movie)
                                }).padding(.vertical)

                                Divider()
                            }
                        }.padding(.horizontal)
                    }
                }, onRetry: {
                    presenter.fetchWatchlist()
                })
            }
        }.navigationTitle("WATCH_LIST")
        .onAppear {
            presenter.fetchWatchlist()
        }
    }
}

// swiftlint:disable line_length
struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView()
            .environmentObject(WatchlistPresenter(watchlistUseCase: MovieWatchlistInjection.init().provideWatchlist()))
    }
}
// swiftlint:enable line_length
