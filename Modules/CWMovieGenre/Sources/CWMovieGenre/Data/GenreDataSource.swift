//
//  GenreDataSource.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine
import Alamofire

import CWAPI
import CWCommon

public protocol GenreDataSourceProtocol: AnyObject {
    func getGenre() -> AnyPublisher<GenreResponse, Error>
}

public final class GenreDataSource: NSObject {
    public static let shared = GenreDataSource()
}

extension GenreDataSource: GenreDataSourceProtocol {
    public func getGenre() -> AnyPublisher<GenreResponse, Error> {
        return Future<GenreResponse, Error> { completion in
            if var urlComponent = URLComponents(string: Endpoints.Get.genre.url) {
                urlComponent.queryItems = [
                    URLQueryItem(name: "api_key", value: API.apiKey)
                ]

                if let url = urlComponent.url {
                    AF.request(url)
                        .validate()
                        .responseDecodable(of: GenreResponse.self) { response in
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
