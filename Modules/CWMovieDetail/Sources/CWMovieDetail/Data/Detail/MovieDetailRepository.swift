//
//  MovieDetailRepository.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine

protocol MovieDetailRepositoryProtocol {
    func getDetail(id: Int) -> AnyPublisher<MovieDetailModel, Error>
}

final class MovieDetailRepository: NSObject {
    typealias MovieDetailInstance = (MovieDetailDataSource) -> MovieDetailRepository

    fileprivate let remote: MovieDetailDataSource

    private init(remote: MovieDetailDataSource) {
        self.remote = remote
    }

    static let sharedInstance: MovieDetailInstance = { remote in
        return MovieDetailRepository(remote: remote)
    }
}

extension MovieDetailRepository: MovieDetailRepositoryProtocol {
    func getDetail(id: Int) -> AnyPublisher<MovieDetailModel, Error> {
        return self.remote.getDetail(id: id)
            .map { MovieDetailMapper.mapMovieDetailToDomains(input: $0) }
                    .eraseToAnyPublisher()
    }
}
