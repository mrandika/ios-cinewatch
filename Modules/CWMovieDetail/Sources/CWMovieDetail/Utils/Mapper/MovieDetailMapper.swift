//
//  MovieDetailMapper.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation

final class MovieDetailMapper {
    static func mapMovieDetailToDomains(input movieDetail: MovieDetail) -> MovieDetailModel {
        return MovieDetailModel(id: movieDetail.id,
                                runtime: movieDetail.runtime,
                                genres: movieDetail.genres,
                                productionCompanies: movieDetail.productionCompanies,
                                tagline: movieDetail.tagline,
                                status: movieDetail.status)
    }
}
