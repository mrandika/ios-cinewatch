//
//  File.swift
//  
//
//  Created by Andika on 18/11/21.
//

import Foundation

public struct GenreResponse: Codable {
    let genres: [Genre]
}

public struct Genre: Codable {
    let id: Int
    let name: String
}

extension GenreResponse {
    static func fake() -> Self {
        return GenreResponse(genres: [
            Genre(id: 1, name: "Action"),
            Genre(id: 2, name: "Adventure")
        ])
    }
}
