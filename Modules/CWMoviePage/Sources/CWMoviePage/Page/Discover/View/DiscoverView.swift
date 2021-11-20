//
//  DiscoverView.swift
//  CineWatch
//
//  Created by Andika on 12/11/21.
//

import SwiftUI

import CWMovie
import CWDetailPage
import CWSharedView

public struct DiscoverView: View {
    @EnvironmentObject var presenter: DiscoverPresenter

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
                                MovieBackdrop(movie: movie, fullsize: true)
                            })

                            Divider()
                        }

                        if !presenter.moviesLoaded {
                            LoadingState(title: "GETTING_MORE_MOVIES")
                                .padding(.vertical)
                                .onAppear {
                                    presenter.fetchDiscovery(skipLoadingBehaviour: true)
                                }
                        }
                    }.padding(.horizontal)
                }
            }, onRetry: {
                presenter.fetchDiscovery()
            }).navigationTitle("DISCOVER")
        }.onAppear {
            if presenter.movies.isEmpty && !presenter.isError {
                presenter.fetchDiscovery()
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(DiscoverPresenter(discoverUseCase: MovieInjection.init().provideDiscover()))
    }
}
