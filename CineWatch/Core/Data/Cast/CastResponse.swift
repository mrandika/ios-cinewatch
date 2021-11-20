//
//  CastResponse.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation

struct CastResponse: Codable {
    let cast: [Cast]
}

struct Cast: Codable {
    let id: Int
    let departement: String
    let name: String
    let profilePath: String?
    let character: String

    private enum CodingKeys: String, CodingKey {
        case id, name, character
        case departement = "known_for_department"
        case profilePath = "profile_path"
    }
}
