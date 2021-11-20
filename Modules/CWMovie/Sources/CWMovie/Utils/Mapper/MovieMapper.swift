//
//  MovieMapper.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import Foundation

final class MovieMapper {
    static func mapMovieResponsesToDomains(input movieResponse: MovieResponse) -> [MovieModel] {
        return movieResponse.results.map { result in
            return MovieModel(
                id: result.id,
                posterPath: result.posterPath ?? "",
                backdropPath: result.backdropPath ?? "",
                isAdultRated: result.isAdultRated,
                overview: result.overview,
                releaseDate: result.releaseDate ?? Date(timeIntervalSince1970: 0),
                title: result.title,
                language: result.language,
                voteAverage: result.voteAverage)
        }
    }
}
