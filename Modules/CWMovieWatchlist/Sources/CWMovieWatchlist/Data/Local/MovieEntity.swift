//
//  MovieEntity.swift
//  CineWatch
//
//  Created by Andika on 29/10/21.
//

import Foundation
import RealmSwift

public class MovieEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var posterPath: String = ""
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var isAdultRated: Bool = false
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseDate: Date = Date(timeIntervalSince1970: 0)
    @objc dynamic var title: String = ""
    @objc dynamic var language: String = ""
    @objc dynamic var voteAverage: Double = 0

    @objc dynamic var addedAt: Date = Date()

    public override class func primaryKey() -> String? {
        return "id"
    }
}
