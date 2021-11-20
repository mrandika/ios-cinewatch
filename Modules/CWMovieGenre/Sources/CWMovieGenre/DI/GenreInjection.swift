//
//  File.swift
//
//
//  Created by Andika on 10/11/21.
//

import Foundation

public final class GenreInjection: NSObject {
    private func provideGenreRepository() -> GenreRepositoryProtocol {
        let remote: GenreDataSource = GenreDataSource.shared

        return GenreRepository.sharedInstance(remote)
    }

    public func provideGenre() -> GenreUseCase {
        let repository = provideGenreRepository()
        return GenreInteractor(repository: repository)
    }
}
