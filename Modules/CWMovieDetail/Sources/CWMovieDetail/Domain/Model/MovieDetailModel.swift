//
//  MovieDetailModel.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation

public struct MovieDetailModel: Codable {
    public let id: Int
    public let runtime: Int?
    public let genres: [MovieGenre]?
    public let productionCompanies: [MovieProductionCompany]?
    public let tagline: String?
    public let status: String?

    public var runtimeFormatted: String {
        return "\(runtime ?? 0) \(NSLocalizedString("DURATION_MIN", comment: ""))"
    }

    public var genreText: String? {
        guard let movieGenres = self.genres else {
            return ""
        }

        return movieGenres
            .prefix(3)
            .map { $0.name }
            .joined(separator: ", ")
    }

    public var productionCompanyText: String? {
        guard let productionCompany = self.productionCompanies else {
            return ""
        }

        return productionCompany
            .map { $0.name }
            .joined(separator: ", ")
    }
}

extension MovieDetailModel {
    public static func empty() -> Self {
        return MovieDetailModel(
            id: 0,
            runtime: nil,
            genres: nil,
            productionCompanies: nil,
            tagline: nil,
            status: nil
        )
    }
}
