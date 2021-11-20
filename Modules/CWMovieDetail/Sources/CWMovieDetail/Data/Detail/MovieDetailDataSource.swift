//
//  MovieDetailDataSource.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine
import Alamofire

import CWAPI
import CWCommon

protocol MovieDetailDataSourceProtocol: AnyObject {
    func getDetail(id: Int) -> AnyPublisher<MovieDetail, Error>
}

final class MovieDetailDataSource: NSObject {
    static let shared = MovieDetailDataSource()
}

extension MovieDetailDataSource: MovieDetailDataSourceProtocol {
    func getDetail(id: Int) -> AnyPublisher<MovieDetail, Error> {
        return Future<MovieDetail, Error> { completion in
            if var urlComponent = URLComponents(string: Endpoints.Get.detail.url) {
                urlComponent.path += String(id)
                urlComponent.queryItems = [
                    URLQueryItem(name: "api_key", value: API.apiKey)
                ]

                if let url = urlComponent.url {
                    AF.request(url)
                        .validate()
                        .responseDecodable(of: MovieDetail.self) { response in
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
