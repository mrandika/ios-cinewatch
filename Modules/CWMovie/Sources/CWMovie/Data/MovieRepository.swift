//
//  MovieRepository.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import Foundation
import Combine

public protocol MovieRepositoryProtocol {
    func getDiscover(genre: Int?, page: Int) -> AnyPublisher<[MovieModel], Error>
    func getNowPlaying(page: Int) -> AnyPublisher<[MovieModel], Error>
    func getUpcoming(page: Int) -> AnyPublisher<[MovieModel], Error>
    func getPopular(page: Int) -> AnyPublisher<[MovieModel], Error>
    func search(query: String) -> AnyPublisher<[MovieModel], Error>
}

public final class MovieRepository: NSObject {
    public typealias MovieInstance = (MovieDataSource) -> MovieRepository

    fileprivate let remote: MovieDataSource

    private init(remote: MovieDataSource) {
        self.remote = remote
    }

    public static let shared: MovieInstance = { remote in
        return MovieRepository(remote: remote)
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    public func getDiscover(genre: Int?, page: Int) -> AnyPublisher<[MovieModel], Error> {
        return self.remote.getDiscover(genre: genre, page: page)
            .map { MovieMapper.mapMovieResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }

    public func getNowPlaying(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return self.remote.getNowPlaying(page: page)
            .map { MovieMapper.mapMovieResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }

    public func getUpcoming(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return self.remote.getUpcoming(page: page)
            .map { MovieMapper.mapMovieResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }

    public func getPopular(page: Int) -> AnyPublisher<[MovieModel], Error> {
        return self.remote.getPopular(page: page)
            .map { MovieMapper.mapMovieResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }

    public func search(query: String) -> AnyPublisher<[MovieModel], Error> {
        return self.remote.search(query: query)
            .map { MovieMapper.mapMovieResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
}
