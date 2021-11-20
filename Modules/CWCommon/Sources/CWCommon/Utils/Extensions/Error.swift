//
//  File.swift
//  
//
//  Created by Andika on 07/11/21.
//

import Foundation

public enum EmptyError: Error {
    case empty
}

public enum NetworkError: Error {
    case http(code: Int, message: String)
    case custom(code: Int, message: String)
}

public enum DataError: Error {
    case decodingFail(code: Int, message: String)
    case localStorageFail(code: Int, message: String)
    case custom(code: Int, message: String)
}

// swiftlint:disable line_length
extension NetworkError {
    public static func requestFail(with code: Int) -> Self {
        switch code {
        case 300...399:
            return NetworkError.http(code: code, message: "HTTP_REDIRECTION".localized())
        case 400...499:
            return NetworkError.http(code: code, message: "HTTP_CLIENT_ERROR".localized())
        case 500...599:
            return NetworkError.http(code: code, message: "HTTP_SERVER_ERROR".localized())
        default:
            return NetworkError.custom(code: code, message: "AF_PROCESS_ERROR".localized())
        }
    }
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .http(code, message):
            return "\("HTTP_ERROR_EXPLANATION".localized()): \(NSLocalizedString(message, comment: "")) (\(code))"

        case let .custom(code, message):
            return "\("CUSTOM_NETWORK_ERROR_EXPLANATION".localized()): \(NSLocalizedString(message, comment: "")) (\(code))"
        }
    }
}

extension DataError {
    public static func realmError() -> Self {
        return DataError.localStorageFail(code: -1, message: "REALM_INIT_FAIL".localized())
    }

    public static func realmCreateError() -> Self {
        return DataError.localStorageFail(code: 1, message: "REALM_WRITE_FAIL".localized())
    }

    public static func realmReadError() -> Self {
        return DataError.localStorageFail(code: 2, message: "REALM_READ_FAIL".localized())
    }

    public static func realmDeleteError() -> Self {
        return DataError.localStorageFail(code: 3, message: "REALM_DELETE_FAIL".localized())
    }
}

extension DataError {
    public static func decoderError() -> Self {
        return DataError.decodingFail(code: -1, message: "AF_DECODER_FAIL".localized())
    }

    public static func dataEmpty() -> Self {
        return DataError.custom(code: 1, message: "LOCAL_STORAGE_EMPTY".localized())
    }
}

extension DataError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .decodingFail(code, message):
            return "\("DECODING_ERROR_EXPLANATION".localized()): \(NSLocalizedString(message, comment: "")) (\(code))"

        case let .localStorageFail(code, message):
            return "\("LDB_ERROR_EXPLANATION".localized()): \(NSLocalizedString(message, comment: "")) (\(code))"

        case let .custom(code, message):
            return "\("CUSTOM_DATA_ERROR_EXPLANATION".localized()): \(NSLocalizedString(message, comment: "")) (\(code))"
        }
    }
}
// swiftlint:enable line_length
