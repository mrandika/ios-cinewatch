//
//  MovieDetailPresenter.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine

import CWCommon
import CWMovie
import CWMovieDetail
import CWMovieWatchlist

public class MovieDetailPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let detailUseCase: DetailUseCase
    private let watchlistUseCase: WatchlistUseCase

    @Published var movie: MovieDetailModel = MovieDetailModel.empty()

    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var error: Error = EmptyError.empty

    public init(detailUseCase: DetailUseCase, watchlistUseCase: WatchlistUseCase) {
        self.detailUseCase = detailUseCase
        self.watchlistUseCase = watchlistUseCase
    }

    func fetchMovieDetail(id: Int) {
        self.isLoading = true
        self.isError = false
        self.error = EmptyError.empty

        detailUseCase.getDetail(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.isError = true
                    self.isLoading = false
                    self.error = error
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { movie in
                self.movie = movie
            }).store(in: &cancellables)
    }
}
