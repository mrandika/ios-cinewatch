//
//  WatchlistMapper.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import Foundation

final class WatchlistMapper {
    static func mapMovieDomainsToEntities(input movieModel: WatchlistModel) -> MovieEntity {
        let movie = MovieEntity()

        movie.id = movieModel.id
        movie.posterPath = movieModel.posterPath
        movie.backdropPath = movieModel.backdropPath
        movie.isAdultRated = movieModel.isAdultRated
        movie.overview = movieModel.overview
        movie.releaseDate = movieModel.releaseDate ?? Date(timeIntervalSince1970: 0)
        movie.title = movieModel.title
        movie.language = movieModel.language
        movie.voteAverage = movieModel.voteAverage

        return movie
    }

    static func mapMovieEntitiesToDomains(input movieEntities: [MovieEntity]) -> [WatchlistModel] {
            return movieEntities.map { result in
                return WatchlistModel(
                    id: result.id,
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
