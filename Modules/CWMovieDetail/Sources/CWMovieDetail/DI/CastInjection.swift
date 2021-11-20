//
//  File.swift
//
//
//  Created by Andika on 10/11/21.
//

import Foundation

public final class CastInjection: NSObject {
    private func provideCastRepository() -> CastRepositoryProtocol {
        let remote: CastDataSource = CastDataSource.shared

        return CastRepository.sharedInstance(remote)
    }

    public func provideCast() -> CastUseCase {
        let repository = provideCastRepository()
        return CastInteractor(repository: repository)
    }
}
