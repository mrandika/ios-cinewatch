//
//  GenreMapper.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation

public final class GenreMapper {
    public static func mapGenreResponsesToDomains(input genreResponse: GenreResponse) -> [GenreModel] {
        return genreResponse.genres
            .map { result in
                return GenreModel(id: result.id, name: result.name)
        }
    }
}
