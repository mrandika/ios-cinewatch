//
//  UpcomingView.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import SwiftUI

import CWSharedView
import CWMovie

public struct UpcomingView: View {
    @EnvironmentObject var presenter: UpcomingPresenter

    public init() {}

    public var body: some View {
        NavigationView {
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

                        if !presenter.moviesLoaded {
                            LoadingState(title: "GETTING_MORE_MOVIES")
                                .padding(.vertical)
                                .onAppear {
                                    presenter.fetchUpcoming(skipLoadingBehaviour: true)
                                }
                        }
                    }.padding(.horizontal)
                }
            }, onRetry: {
                presenter.fetchUpcoming()
            }).navigationTitle("UPCOMING")
        }.onAppear {
            if presenter.movies.isEmpty && !presenter.isError {
                presenter.fetchUpcoming()
            }
        }
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
            .environmentObject(UpcomingPresenter(upcomingUseCase: MovieInjection.init().provideUpcoming()))
    }
}
