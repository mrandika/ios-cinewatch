//
//  File.swift
//  
//
//  Created by Andika on 09/11/21.
//

import Foundation
import RealmSwift

public final class MovieWatchlistInjection: NSObject {
    private func provideWatchlistRepository() -> WatchlistRepositoryProtocol {
        let realm = try? Realm()

        let local: WatchlistDataSource = WatchlistDataSource.shared(realm)

        return WatchlistRepository.shared(local)
    }

    public func provideWatchlist() -> WatchlistUseCase {
        let repository = provideWatchlistRepository()
        return WatchlistInteractor(repository: repository)
    }
}
