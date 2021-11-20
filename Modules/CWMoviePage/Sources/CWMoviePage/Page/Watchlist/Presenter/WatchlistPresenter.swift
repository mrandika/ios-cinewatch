//
//  WatchlistPresenter.swift
//  CineWatch
//
//  Created by Andika on 29/10/21.
//

import Foundation
import SwiftUI
import Combine

import CWCommon
import CWMovie
import CWMovieWatchlist
import CWDetailPage

public class WatchlistPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let router = Router()
    private let watchlistUseCase: WatchlistUseCase

    @Published var movies: [MovieModel] = []

    @Published var isLoading: Bool = false
    @Published var taskCompleted: Bool = false
    @Published var isError: Bool = false
    @Published var error: Error = EmptyError.empty

    public init(watchlistUseCase: WatchlistUseCase) {
        self.watchlistUseCase = watchlistUseCase
    }

    public func fetchWatchlist() {
        self.isError = false
        self.error = EmptyError.empty

        watchlistUseCase.getWatchlist()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.isError = true
                    self.error = error
                case .finished:
                    debugPrint("Task finished")
                }
            }, receiveValue: { movies in
                self.movies = MovieTransformer.mapWatchlistsToMovies(input: movies)
            }).store(in: &cancellables)
    }

    public func clearWatchlist() {
        self.isError = false
        self.error = EmptyError.empty

        watchlistUseCase.clearWatchlist()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.isError = true
                    self.error = error
                case .finished:
                    debugPrint("Task finished")
                }
            }, receiveValue: { status in
                if status {
                    self.taskCompleted = status
                    self.movies = []
                }
            }).store(in: &cancellables)
    }

    func navigationLinkBuilder<Content: View>(movie: MovieModel,
                                              @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeDetailView(movie: movie, showShareToolbar: false)) {
            content()
        }.buttonStyle(PlainButtonStyle())
    }
}
