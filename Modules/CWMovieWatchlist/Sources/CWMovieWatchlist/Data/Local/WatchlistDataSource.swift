//
//  WatchlistDataSource.swift
//  CineWatch
//
//  Created by Andika on 29/10/21.
//

import Foundation
import RealmSwift
import Combine

import CWCommon

public protocol WatchlistDataSourceProtocol: AnyObject {
    func getWatchlist() -> AnyPublisher<[MovieEntity], Error>
    func addToWatchlist(movie: MovieEntity) -> AnyPublisher<Bool, Error>
    func removeFromWatchlist(movie: MovieEntity) -> AnyPublisher<Bool, Error>
    func isMovieOnWatchlist(movie: MovieEntity) -> AnyPublisher<Bool, Error>

    func clearWatchlist() -> AnyPublisher<Bool, Error>
}

public final class WatchlistDataSource: NSObject {
    private let realm: Realm?

    private init(realm: Realm?) {
        self.realm = realm
    }

    public static let shared: (Realm?) -> WatchlistDataSource = { realmDatabase in
        return WatchlistDataSource(realm: realmDatabase)
    }
}

extension WatchlistDataSource: WatchlistDataSourceProtocol {
    public func getWatchlist() -> AnyPublisher<[MovieEntity], Error> {
        return Future<[MovieEntity], Error> { completion in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .sorted(byKeyPath: "addedAt", ascending: false)
                }()

                completion(.success(movies.toArray(ofType: MovieEntity.self)))
            } else {
                completion(.failure(DataError.realmError()))
            }
        }.eraseToAnyPublisher()
    }

    public func addToWatchlist(movie: MovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(movie, update: .modified)
                    }

                    completion(.success(true))
                } catch {
                    completion(.failure(DataError.realmCreateError()))
                }
            } else {
                completion(.failure(DataError.realmError()))
            }
        }.eraseToAnyPublisher()
    }

    public func removeFromWatchlist(movie: MovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    let movie = realm.objects(MovieEntity.self).filter("id == \(movie.id)")

                    try realm.write {
                        realm.delete(movie)
                    }

                    completion(.success(true))
                } catch {
                    completion(.failure(DataError.realmDeleteError()))
                }
            } else {
                completion(.failure(DataError.realmError()))
            }
        }.eraseToAnyPublisher()
    }

    public func isMovieOnWatchlist(movie: MovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                let movies = realm.objects(MovieEntity.self).filter("id == \(movie.id)")

                if !movies.isEmpty {
                    completion(.success(true))
                } else {
                    completion(.success(false))
                }
            } else {
                completion(.failure(DataError.realmError()))
            }
        }.eraseToAnyPublisher()
    }

    public func clearWatchlist() -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.deleteAll()
                    }

                    completion(.success(true))
                } catch {
                    completion(.failure(DataError.realmDeleteError()))
                }
            } else {
                completion(.failure(DataError.realmError()))
            }
        }.eraseToAnyPublisher()
    }
}
