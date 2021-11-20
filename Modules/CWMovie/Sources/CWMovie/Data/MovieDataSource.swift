//
//  MovieDataSource.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import Foundation
import Alamofire
import Combine

import CWAPI
import CWCommon

public protocol MovieDataSourceProtocol: AnyObject {
    func getDiscover(genre: Int?, page: Int) -> AnyPublisher<MovieResponse, Error>
    func getNowPlaying(page: Int) -> AnyPublisher<MovieResponse, Error>
    func getUpcoming(page: Int) -> AnyPublisher<MovieResponse, Error>
    func getPopular(page: Int) -> AnyPublisher<MovieResponse, Error>
    func search(query: String) -> AnyPublisher<MovieResponse, Error>
}

public final class MovieDataSource: NSObject {
    public static let shared = MovieDataSource()
}

extension MovieDataSource: MovieDataSourceProtocol {
    public func getDiscover(genre: Int?, page: Int) -> AnyPublisher<MovieResponse, Error> {
        return Future<MovieResponse, Error> { completion in
            if var urlComponent = URLComponents(string: Endpoints.Get.discover.url) {
                urlComponent.queryItems = [
                    URLQueryItem(name: "api_key", value: API.apiKey),
                    URLQueryItem(name: "page", value: String(page))
                ]

                if let genre = genre {
                    urlComponent.queryItems?.append(URLQueryItem(name: "with_genres", value: String(genre)))
                }

                if let url = urlComponent.url {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)

                    AF.request(url)
                        .validate()
                        .responseDecodable(of: MovieResponse.self, decoder: decoder) { response in
                            switch response.result {
                            case .success(let response):
                                completion(.success(response))
                            case .failure(let error):
                                if error.isResponseSerializationError {
                                    completion(.failure(DataError.decoderError()))
                                } else {
                                    completion(.failure(
                                        NetworkError.requestFail(with: error.responseCode ?? -1))
                                    )
                                }
                            }
                        }
                }
            }
        }.eraseToAnyPublisher()
    }

    public func getNowPlaying(page: Int) -> AnyPublisher<MovieResponse, Error> {
        return Future<MovieResponse, Error> { completion in
            if var urlComponent = URLComponents(string: Endpoints.Get.nowPlaying.url) {
                urlComponent.queryItems = [
                    URLQueryItem(name: "api_key", value: API.apiKey),
                    URLQueryItem(name: "page", value: String(page))
                ]

                if let url = urlComponent.url {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)

                    AF.request(url)
                        .validate()
                        .responseDecodable(of: MovieResponse.self, decoder: decoder) { response in
                            switch response.result {
                            case .success(let response):
                                completion(.success(response))
                            case .failure(let error):
                                if error.isResponseSerializationError {
                                    completion(.failure(DataError.decoderError()))
                                } else {
                                    completion(.failure(
                                        NetworkError.requestFail(with: error.responseCode ?? -1))
                                    )
                                }
                            }
                        }
                }
            }
        }.eraseToAnyPublisher()
    }

    public func getUpcoming(page: Int) -> AnyPublisher<MovieResponse, Error> {
        return Future<MovieResponse, Error> { completion in
            if var urlComponent = URLComponents(string: Endpoints.Get.upcoming.url) {
                urlComponent.queryItems = [
                    URLQueryItem(name: "api_key", value: API.apiKey),
                    URLQueryItem(name: "page", value: String(page))
                ]

                if let url = urlComponent.url {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)

                    AF.request(url)
                        .validate()
                        .responseDecodable(of: MovieResponse.self, decoder: decoder) { response in
                            switch response.result {
                            case .success(let response):
                                completion(.success(response))
                            case .failure(let error):
                                if error.isResponseSerializationError {
                                    completion(.failure(DataError.decoderError()))
                                } else {
                                    completion(.failure(
                                        NetworkError.requestFail(with: error.responseCode ?? -1))
                                    )
                                }
                            }
                        }
                }
            }
        }.eraseToAnyPublisher()
    }

    public func getPopular(page: Int) -> AnyPublisher<MovieResponse, Error> {
        return Future<MovieResponse, Error> { completion in
            if var urlComponent = URLComponents(string: Endpoints.Get.popular.url) {
                urlComponent.queryItems = [
                    URLQueryItem(name: "api_key", value: API.apiKey),
                    URLQueryItem(name: "page", value: String(page))
                ]

                if let url = urlComponent.url {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)

                    AF.request(url)
                        .validate()
                        .responseDecodable(of: MovieResponse.self, decoder: decoder) { response in
                            switch response.result {
                            case .success(let response):
                                completion(.success(response))
                            case .failure(let error):
                                if error.isResponseSerializationError {
                                    completion(.failure(DataError.decoderError()))
                                } else {
                                    completion(.failure(
                                        NetworkError.requestFail(with: error.responseCode ?? -1))
                                    )
                                }
                            }
                        }
                }
            }
        }.eraseToAnyPublisher()
    }

    public func search(query: String) -> AnyPublisher<MovieResponse, Error> {
        return Future<MovieResponse, Error> { completion in
            if var urlComponent = URLComponents(string: Endpoints.Get.search.url) {
                urlComponent.queryItems = [
                    URLQueryItem(name: "api_key", value: API.apiKey),
                    URLQueryItem(name: "query", value: query)
                ]

                if let url = urlComponent.url {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)

                    AF.request(url)
                        .validate()
                        .responseDecodable(of: MovieResponse.self, decoder: decoder) { response in
                            switch response.result {
                            case .success(let response):
                                completion(.success(response))
                            case .failure(let error):
                                if error.isResponseSerializationError {
                                    completion(.failure(DataError.decoderError()))
                                } else {
                                    completion(.failure(
                                        NetworkError.requestFail(with: error.responseCode ?? -1))
                                    )
                                }
                            }
                        }
                }
            }
        }.eraseToAnyPublisher()
    }
}
