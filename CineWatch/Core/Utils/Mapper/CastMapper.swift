//
//  CastMapper.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation

final class CastMapper {
    static func mapCastResponsesToDomains(input castResponse: CastResponse) -> [CastModel] {
        return castResponse.cast
            .filter { $0.departement == "Acting" }
            .prefix(10)
            .map { result in
                return CastModel(id: result.id,
                                 departement: result.departement,
                                 name: result.name,
                                 profilePath: result.profilePath,
                                 character: result.character)
        }
    }
}
