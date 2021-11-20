//
//  MovieDetailResponse.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import Foundation

public struct MovieDetail: Codable {
    public let id: Int
    public let runtime: Int?
    public let genres: [MovieGenre]?
    public let productionCompanies: [MovieProductionCompany]?
    public let tagline: String?
    public let status: String?

    private enum CodingKeys: String, CodingKey {
        case id, runtime, genres, tagline, status
        case productionCompanies = "production_companies"
    }
}

public struct MovieGenre: Codable {
    public let id: Int
    public let name: String
}

public struct MovieProductionCompany: Codable {
    public let id: Int
    public let name: String
}

extension MovieDetail {
    static func fake() -> Self {
        return MovieDetail(id: 1, runtime: 0, genres: [
            MovieGenre(id: 1, name: "Action")
        ], productionCompanies: [
            MovieProductionCompany(id: 1, name: "Movie House")
        ], tagline: "Beyond lorem ipsum!", status: "released")
    }
}
