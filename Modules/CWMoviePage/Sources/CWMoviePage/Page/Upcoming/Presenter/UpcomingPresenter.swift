//
//  UpcomingPresenter.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import SwiftUI
import Combine

import CWCommon
import CWMovie

public class UpcomingPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let router = Router()
    private let upcomingUseCase: UpcomingUseCase

    @Published var movies: [MovieModel] = []

    // Pagination
    var moviesLoaded = false
    var maxResult = 20
    var page = 1

    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var error: Error = EmptyError.empty

    public init(upcomingUseCase: UpcomingUseCase) {
        self.upcomingUseCase = upcomingUseCase
    }

    func fetchUpcoming(skipLoadingBehaviour: Bool = false) {
        if !skipLoadingBehaviour {
            self.isLoading = true
        }

        self.isError = false
        self.error = EmptyError.empty

        upcomingUseCase.getUpcoming(page: page)
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
                self.movies.append(contentsOf: movies)

                if movies.count < self.maxResult {
                    self.moviesLoaded = true
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
