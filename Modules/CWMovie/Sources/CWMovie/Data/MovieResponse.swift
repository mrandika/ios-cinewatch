//
//  MovieResponse.swift
//  CineWatch
//
//  Created by Andika on 22/10/21.
//

import Foundation

public struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
}

// swiftlint:disable line_length
public struct Movie: Codable {
    let id: Int
    let posterPath, backdropPath: String?
    let isAdultRated: Bool
    let overview: String
    let releaseDate: Date?
    let title: String
    let language: String
    let voteAverage: Double

    private enum CodingKeys: String, CodingKey {
        case id, overview, title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case isAdultRated = "adult"
        case releaseDate = "release_date"
        case language = "original_language"
        case voteAverage = "vote_average"
    }

    /*
     * Documentation & Complaint:
     * This method required as TMDB API ((blatantly)) returns an empty string instead of null in their release date key.
     * However, their docs say that this key is an string (not an "string or null" like other nullable keys).
     * Causing JSONDecoder to be mad 😡
     *
     * This init() method returns nil if the keyed value is null or empty.
     */
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        posterPath = try? container.decode(String.self, forKey: .posterPath)
        backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        isAdultRated = try container.decode(Bool.self, forKey: .isAdultRated)
        overview = try container.decode(String.self, forKey: .overview)
        releaseDate = try? container.decode(Date.self, forKey: .releaseDate)
        title = try container.decode(String.self, forKey: .title)
        language = try container.decode(String.self, forKey: .language)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
    }
}
// swiftlint:enable line_length

extension MovieResponse {
    static func fake() -> Self {
        return MovieResponse(page: 1, results: [])
    }
}
