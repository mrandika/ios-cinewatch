//
//  CastResponse.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation

public struct CastResponse: Codable {
    public let cast: [Cast]
}

public struct Cast: Codable {
    public let id: Int
    public let departement: String
    public let name: String
    public let profilePath: String?
    public let character: String

    private enum CodingKeys: String, CodingKey {
        case id, name, character
        case departement = "known_for_department"
        case profilePath = "profile_path"
    }
}

extension CastResponse {
    static func fake() -> Self {
        return CastResponse(cast: [
            Cast(id: 1, departement: "Acting", name: "A", profilePath: nil, character: "B"),
            Cast(id: 1, departement: "Acting", name: "C", profilePath: nil, character: "D")
        ])
    }
}
