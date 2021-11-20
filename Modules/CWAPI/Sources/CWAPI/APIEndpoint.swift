//
//  APIEndpoint.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import Foundation

// swiftlint:disable line_length
public struct API {
    static let baseUrl = "https://api.themoviedb.org/3"
    public static var apiKey: String {
        guard let filePath = Bundle.module.path(forResource: "TMDB-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'TMDB-Info.plist'.")
        }

        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'TMDB-Info.plist'.")
        }

        if value.starts(with: "_") {
            fatalError("Register for a TMDB developer account and get an API key at https://developers.themoviedb.org/3/getting-started/introduction.")
        }

        return value
    }
}

protocol Endpoint {
    var url: String { get }
}

public enum Endpoints {
    public enum Get: Endpoint {
        case discover
        case nowPlaying
        case upcoming
        case popular
        case detail
        case search

        case genre

        public var url: String {
            switch self {
            case .discover: return "\(API.baseUrl)/discover/movie"
            case .nowPlaying: return "\(API.baseUrl)/movie/now_playing"
            case .upcoming: return "\(API.baseUrl)/movie/upcoming"
            case .popular: return "\(API.baseUrl)/movie/popular"
            case .detail: return "\(API.baseUrl)/movie/"
            case .search: return "\(API.baseUrl)/search/movie"
            case .genre: return "\(API.baseUrl)/genre/movie/list"
            }
        }
    }
}
// swiftlint:enable line_length
