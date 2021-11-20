//
//  Router.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import SwiftUI

import CWMovie
import CWMovieDetail
import CWDetailPage
import CWMovieWatchlist

public class Router {
    public func makeDetailView(movie: MovieModel, showShareToolbar: Bool = true) -> some View {
        let detailUseCase = MovieDetailInjection.init().provideDetail()
        let castUseCase = CastInjection.init().provideCast()
        let watchlistUseCase = MovieWatchlistInjection.init().provideWatchlist()

        let presenter = MovieDetailPresenter(detailUseCase: detailUseCase, watchlistUseCase: watchlistUseCase)
        let castPresenter = CastPresenter(castUseCase: castUseCase)

        return MovieDetailView(presenter: presenter,
                               castPresenter: castPresenter,
                               movie: movie,
                               showShareToolbar: showShareToolbar)
    }
}
