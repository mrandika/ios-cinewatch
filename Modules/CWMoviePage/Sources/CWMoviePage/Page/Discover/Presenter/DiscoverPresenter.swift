//
//  DiscoverPresenter.swift
//  CineWatch
//
//  Created by Andika on 12/11/21.
//

import Foundation
import SwiftUI
import Combine

import CWCommon
import CWMovie

public class DiscoverPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let router = Router()
    private let discoverUseCase: DiscoverUseCase

    @Published var movies: [MovieModel] = []
    @Published var genre: Int?

    // Pagination
    var moviesLoaded = false
    var maxResult = 20
    var page = 1

    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var error: Error = EmptyError.empty

    public init(discoverUseCase: DiscoverUseCase) {
        self.discoverUseCase = discoverUseCase
        self.genre = UserDefaults.standard.object(forKey: "cw.settings.genre") as? Int? ?? nil
    }

    public func fetchDiscovery(skipLoadingBehaviour: Bool = false) {
        if let genre = UserDefaults.standard.object(forKey: "cw.settings.genre") as? Int?,
           genre != 0, genre != self.genre {
            self.page = 1
            self.genre = genre
        }

        if !skipLoadingBehaviour {
            self.isLoading = true
        }

        self.isError = false
        self.error = EmptyError.empty

        discoverUseCase.getDiscover(genre: genre, page: page)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.isError = true

                    if !skipLoadingBehaviour {
                        self.isLoading = false
                    }

                    self.error = error
                case .finished:
                    self.page += 1

                    if !skipLoadingBehaviour {
                        self.isLoading = false
                    }
                }
            }, receiveValue: { movies in
                if skipLoadingBehaviour {
                    self.movies.append(contentsOf: movies)

                    if movies.count < self.maxResult {
                        self.moviesLoaded = true
                    }
                } else {
                    self.movies = movies
                }
            }).store(in: &cancellables)
    }

    func navigationLinkBuilder<Content: View>(movie: MovieModel,
                                              @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeDetailView(movie: movie)) {
            content()
        }.buttonStyle(PlainButtonStyle())
    }
}
