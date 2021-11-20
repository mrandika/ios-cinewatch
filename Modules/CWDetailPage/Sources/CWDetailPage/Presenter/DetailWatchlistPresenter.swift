//
//  WatchlistPresenter.swift
//  CineWatch
//
//  Created by Andika on 29/10/21.
//

import Foundation
import SwiftUI
import Combine

import CWMovie
import CWMovieWatchlist
import CWCommon

public class DetailWatchlistPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let watchlistUseCase: WatchlistUseCase

    @Published var movies: [MovieModel] = []
    @Published var isMovieOnWatchlist: Bool = false

    @Published var isLoading: Bool = false
    @Published var taskCompleted: Bool = false
    @Published var isError: Bool = false
    @Published var error: Error = EmptyError.empty

    public init(watchlistUseCase: WatchlistUseCase) {
        self.watchlistUseCase = watchlistUseCase
    }

    func fetchWatchlist() {
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

    func addToWatchlist(movie: MovieModel) {
        self.isError = false
        self.error = EmptyError.empty

        watchlistUseCase.addToWatchlist(movie: MovieTransformer.mapMovieToWatchlist(input: movie))
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
                self.isMovieOnWatchlist = status
            }).store(in: &cancellables)
    }

    func removeFromWatchlist(movie: MovieModel) {
        self.isError = false
        self.error = EmptyError.empty

        watchlistUseCase.removeFromWatchlist(movie: MovieTransformer.mapMovieToWatchlist(input: movie))
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
                // Negate the status to trigger UI changes
                self.isMovieOnWatchlist = !status
            }).store(in: &cancellables)
    }

    func isMovieOnWatchlist(movie: MovieModel) {
        self.isError = false
        self.error = EmptyError.empty

        watchlistUseCase.isMovieOnWatchlist(movie: MovieTransformer.mapMovieToWatchlist(input: movie))
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
                self.isMovieOnWatchlist = status
            }).store(in: &cancellables)
    }
}
