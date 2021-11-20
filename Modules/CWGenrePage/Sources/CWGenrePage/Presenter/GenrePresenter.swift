//
//  GenrePresenter.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import SwiftUI
import Combine

import CWCommon
import CWMovieGenre

public class GenrePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let genreUseCase: GenreUseCase

    @Published var genres: [GenreModel] = []

    @Published var genre: Int? {
        didSet {
            UserDefaults.standard.set(genre, forKey: "cw.settings.genre")
        }
    }

    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var error: Error = EmptyError.empty

    public init(genreUseCase: GenreUseCase) {
        self.genreUseCase = genreUseCase
        self.genre = UserDefaults.standard.object(forKey: "cw.settings.genre") as? Int? ?? nil
    }

    func fetchGenres() {
        self.isLoading = true
        self.isError = false
        self.error = EmptyError.empty

        genreUseCase.getGenre()
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
            }, receiveValue: { genres in
                self.genres = genres
            }).store(in: &cancellables)
    }

    func isGenreSelected(id: Int) -> Bool {
        return id == genre
    }
}
