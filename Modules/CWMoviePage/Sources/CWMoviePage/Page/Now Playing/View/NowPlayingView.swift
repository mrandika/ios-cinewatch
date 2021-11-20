//
//  NowPlayingView.swift
//  CineWatch
//
//  Created by Andika on 21/10/21.
//

import SwiftUI

import CWMovie
import CWSharedView

public struct NowPlayingView: View {
    @EnvironmentObject var presenter: NowPlayingPresenter

    public init() {}

    public var body: some View {
        NavigationView {
            StateContainer(isLoading: $presenter.isLoading,
                           isError: $presenter.isError,
                           error: presenter.error, content: {
                ScrollView {
                    LazyVStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(presenter.movies.prefix(5), id: \.id) { movie in
                                    presenter.navigationLinkBuilder(movie: movie, content: {
                                        MovieBackdrop(movie: movie)
                                    })
                                }
                            }
                        }.padding(.vertical)

                        Divider()

                        ForEach(presenter.movies.dropFirst(5), id: \.id) { movie in
                            presenter.navigationLinkBuilder(movie: movie, content: {
                                MoviePoster(movie: movie)
                            }).padding(.vertical)

                            Divider()
                        }

                        if !presenter.moviesLoaded {
                            LoadingState(title: "GETTING_MORE_MOVIES")
                                .padding(.vertical)
                                .onAppear {
                                    presenter.fetchNowPlaying(skipLoadingBehaviour: true)
                                }
                        }
                    }.padding(.horizontal)
                }
            }, onRetry: {
                presenter.fetchNowPlaying()
            }).navigationTitle("NOW_PLAYING")
        }.onAppear {
            if presenter.movies.isEmpty && !presenter.isError {
                presenter.fetchNowPlaying()
            }
        }
    }
}

// swiftlint:disable line_length
struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
            .environmentObject(NowPlayingPresenter(nowPlayingUseCase: MovieInjection.init().provideNowPlaying()))
    }
}
// swiftlint:enable line_length
