//
//  SearchPresenter.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import SwiftUI
import Combine

import CWCommon
import CWMovie

public class SearchPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let router = Router()
    private let searchUseCase: SearchUseCase

    @Published var movies: [MovieModel] = []

    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var error: Error = EmptyError.empty

    public init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
    }

    func fetchSearchResult(for query: String) {
        self.isLoading = true
        self.isError = false
        self.error = EmptyError.empty

        searchUseCase.search(query: query)
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
            }, receiveValue: { movies in
                self.movies = movies
            }).store(in: &cancellables)
    }

    func navigationLinkBuilder<Content: View>(movie: MovieModel,
                                              @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeDetailView(movie: movie)) {
            content()
        }.buttonStyle(PlainButtonStyle())
    }
}
