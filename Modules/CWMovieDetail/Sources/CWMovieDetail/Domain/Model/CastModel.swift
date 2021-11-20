//
//  CastModel.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation

public struct CastModel: Codable {
    public let id: Int
    public let departement: String
    public let name: String
    public let profilePath: String?
    public let character: String

    public var profileUrl: URL {
        return URL(string: "https://image.tmdb.org/t/p/w185" + (profilePath ?? ""))!
    }

    public var characterAs: String {
        return "\(NSLocalizedString("CHARACTER_AS", comment: "")) \(character.isEmpty ? "-" : character)"
    }
}

extension CastModel {
    public static func fake() -> Self {
        return CastModel(id: 1190668,
                         departement: "Acting",
                         name: "Timothée Chalamet",
                         profilePath: "/8jNFfNmqHVqLHnGnxgu7y8xgRIa.jpg",
                         character: "Paul Atreides")
    }
}
