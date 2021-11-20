//
//  CastDataSource.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import Foundation
import Combine
import Alamofire

import CWAPI
import CWCommon

public protocol CastDataSourceProtocol: AnyObject {
    func getCast(movieId: Int) -> AnyPublisher<CastResponse, Error>
}

public final class CastDataSource: NSObject {
    public static let shared = CastDataSource()
}

extension CastDataSource: CastDataSourceProtocol {
    public func getCast(movieId: Int) -> AnyPublisher<CastResponse, Error> {
        return Future<CastResponse, Error> { completion in
            if var urlComponent = URLComponents(string: Endpoints.Get.detail.url) {
                urlComponent.path += String(movieId)
                urlComponent.path += "/credits"
                urlComponent.queryItems = [
                    URLQueryItem(name: "api_key", value: API.apiKey)
                ]

                if let url = urlComponent.url {
                    AF.request(url)
                        .validate()
                        .responseDecodable(of: CastResponse.self) { response in
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
