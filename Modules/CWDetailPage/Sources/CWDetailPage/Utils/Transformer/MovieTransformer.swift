//
//  MovieTransformer.swift
//  CineWatch
//
//  Created by Andika on 10/11/21.
//

import Foundation

import CWMovie
import CWMovieWatchlist

public final class MovieTransformer {
    public static func mapMovieToWatchlist(input movieModel: MovieModel) -> WatchlistModel {
        return WatchlistModel(id: movieModel.id,
                              posterPath: movieModel.posterPath,
                              backdropPath: movieModel.backdropPath,
                              isAdultRated: movieModel.isAdultRated,
                              overview: movieModel.overview,
                              releaseDate: movieModel.releaseDate,
                              title: movieModel.title,
                              language: movieModel.language,
                              voteAverage: movieModel.voteAverage)
    }

    public static func mapWatchlistToMovie(input watchlistModel: WatchlistModel) -> MovieModel {
        return MovieModel(id: watchlistModel.id,
                              posterPath: watchlistModel.posterPath,
                              backdropPath: watchlistModel.backdropPath,
                              isAdultRated: watchlistModel.isAdultRated,
                              overview: watchlistModel.overview,
                              releaseDate: watchlistModel.releaseDate,
                              title: watchlistModel.title,
                              language: watchlistModel.language,
                              voteAverage: watchlistModel.voteAverage)
    }

    public static func mapWatchlistsToMovies(input watchlistModel: [WatchlistModel]) -> [MovieModel] {
        return watchlistModel.map { result in
            return MovieModel(id: result.id,
                                 posterPath: result.posterPath,
                                 backdropPath: result.backdropPath,
                                 isAdultRated: result.isAdultRated,
                                 overview: result.overview,
                                 releaseDate: result.releaseDate,
                                 title: result.title,
                                 language: result.language,
                                 voteAverage: result.voteAverage)
        }
    }
}
