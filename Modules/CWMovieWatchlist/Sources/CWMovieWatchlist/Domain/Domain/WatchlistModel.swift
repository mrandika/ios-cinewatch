//
//  WatchlistModel.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import Foundation

public struct WatchlistModel: Equatable, Identifiable {
    public let id: Int
    public let posterPath, backdropPath: String
    public let isAdultRated: Bool
    public let overview: String
    public let releaseDate: Date?
    public let title: String
    public let language: String
    public let voteAverage: Double

    public var posterUrl: URL {
        return URL(string: "https://image.tmdb.org/t/p/w185" + posterPath)!
    }

    public var higherResolutionPosterUrl: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)!
    }

    public var backdropUrl: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500" + backdropPath)!
    }

    public var higherResolutionBackdropUrl: URL {
        return URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
    }

    public var releaseYearDate: String {
        if releaseDate == Date(timeIntervalSince1970: 0) {
            return "-"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY"

            return dateFormatter.string(from: releaseDate ?? Date(timeIntervalSince1970: 0))
        }
    }

    public var releaseCompleteDate: String {
        if releaseDate == Date(timeIntervalSince1970: 0) {
            return "-"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, YYYY"

            return dateFormatter.string(from: releaseDate ?? Date(timeIntervalSince1970: 0))
        }
    }

    public var capitalLanguage: String {
        return language.uppercased()
    }

    public init(id: Int,
                posterPath: String,
                backdropPath: String,
                isAdultRated: Bool,
                overview: String,
                releaseDate: Date?,
                title: String,
                language: String,
                voteAverage: Double) {
        self.id = id
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.isAdultRated = isAdultRated
        self.overview = overview
        self.releaseDate = releaseDate
        self.title = title
        self.language = language
        self.voteAverage = voteAverage
    }
}
// swiftlint:enable identifier_name

// swiftlint:disable line_length
extension WatchlistModel {
    public static func fake() -> Self {
        return WatchlistModel(id: 438631, posterPath: "/d5NXSklXo0qyIYkgV94XAgMIckC.jpg", backdropPath: "/gOglaWhGx246MvzpnYMZ7HiBkiK.jpg", isAdultRated: true, overview: "Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet's exclusive supply of the most precious resource in existence-a commodity capable of unlocking humanity's greatest potential-only those who can conquer their fear will survive.", releaseDate: Date(), title: "Dune", language: "en", voteAverage: 8.1)
    }

    public static func fakes() -> [Self] {
        return [
            WatchlistModel(id: 438631, posterPath: "/d5NXSklXo0qyIYkgV94XAgMIckC.jpg", backdropPath: "/gOglaWhGx246MvzpnYMZ7HiBkiK.jpg", isAdultRated: false, overview: "Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet's exclusive supply of the most precious resource in existence-a commodity capable of unlocking humanity's greatest potential-only those who can conquer their fear will survive.", releaseDate: Date(), title: "Dune", language: "en", voteAverage: 8.1)
        ]
    }
}
