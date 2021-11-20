//
//  PopularViewComponent.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import SwiftUI
import CWMovie

import CWSharedView

struct PopularViewComponent: View {
    @ObservedObject var presenter: PopularPresenter

    var body: some View {
        VStack {
            StateContainer(isLoading: $presenter.isLoading,
                           isError: $presenter.isError,
                           error: presenter.error, content: {
                ScrollView {
                    HStack {
                        Text("DISCOVER_CINEWATCH")
                            .font(.title2)
                            .bold()

                        Spacer()
                    }.padding()

                    LazyVStack {
                        ForEach(presenter.movies, id: \.id) { movie in
                            presenter.navigationLinkBuilder(movie: movie, content: {
                                MoviePoster(movie: movie, showReleaseYear: true)
                            }).padding(.vertical)

                            Divider()
                        }
                    }.padding(.horizontal)
                }
            }, onRetry: {
                presenter.fetchPopular()
            })
        }.onAppear {
            if presenter.movies.isEmpty && !presenter.isError {
                presenter.fetchPopular()
            }
        }
    }
}

// swiftlint:disable line_length
struct PopularViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        PopularViewComponent(presenter: PopularPresenter(popularUseCase: MovieInjection.init().providePopular()))
    }
}
// swiftlint:enable line_length
