//
//  SearchResultViewComponent.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import SwiftUI

import CWCommon
import CWSharedView
import CWMovie

struct SearchResultViewComponent: View {
    @ObservedObject var presenter: SearchPresenter
    var query: String

    var body: some View {
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
                    HStack {
                        Text("RESULTS_FOR \(query)")
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
                presenter.fetchSearchResult(for: query)
            })
        }
    }
}

struct SearchResultViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultViewComponent(presenter:
                                    SearchPresenter(
                                        searchUseCase: MovieInjection.init().provideSearch()),
                                  query: "Start-Up")
    }
}
