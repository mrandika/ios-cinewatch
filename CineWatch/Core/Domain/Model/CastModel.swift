//
//  CastModel.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation

struct CastModel: Codable {
    let id: Int
    let departement: String
    let name: String
    let profilePath: String?
    let character: String

    var profileUrl: URL {
        return URL(string: "https://image.tmdb.org/t/p/w185" + (profilePath ?? ""))!
    }

    var characterAs: String {
        return "\(NSLocalizedString("CHARACTER_AS", comment: "")) \(character.isEmpty ? "-" : character)"
    }
}

extension CastModel {
    static func fake() -> Self {
        return CastModel(id: 1190668,
                         departement: "Acting",
                         name: "Timothée Chalamet",
                         profilePath: "/8jNFfNmqHVqLHnGnxgu7y8xgRIa.jpg",
                         character: "Paul Atreides")
    }
}
