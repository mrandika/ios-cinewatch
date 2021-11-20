//
//  File.swift
//
//
//  Created by Andika on 10/11/21.
//

import Foundation

public final class MovieDetailInjection: NSObject {
    private func provideMovieDetailRepository() -> MovieDetailRepositoryProtocol {
        let remote: MovieDetailDataSource = MovieDetailDataSource.shared

        return MovieDetailRepository.sharedInstance(remote)
    }

    public func provideDetail() -> DetailUseCase {
        let repository = provideMovieDetailRepository()
        return DetailInteractor(repository: repository)
    }
}
