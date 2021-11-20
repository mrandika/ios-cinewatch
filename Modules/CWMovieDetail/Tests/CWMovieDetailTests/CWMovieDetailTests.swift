import XCTest
import Alamofire
import Mocker
@testable import CWMovieDetail

// swiftlint:disable line_length force_try
final class CWMovieDetailTests: XCTestCase {
    func testDetailRemoteData() throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)

        let fakeApiKey = UUID().uuidString
        let apiEndpoint = URL(string: "https://api.themoviedb.org/3/movie/566525?api_key=\(fakeApiKey)")!

        let jsonData = try String(contentsOf: MockedData.movieJSON).data(using: .utf8)
        let expectedData = try JSONDecoder().decode(MovieDetail.self, from: jsonData!)
        let requestExpectation = expectation(description: "Request should finish")

        let mockedData = try! JSONEncoder().encode(expectedData)
        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        mock.register()

        sessionManager
            .request(apiEndpoint)
            .responseDecodable(of: MovieDetail.self) { (response) in
                XCTAssertNotNil(response)

                switch response.result {
                case .success(let data):
                    XCTAssertNotNil(data)
                    requestExpectation.fulfill()
                case .failure(_):
                    XCTFail("Failure in result!")
                }
            }.resume()

        wait(for: [requestExpectation], timeout: 10.0)
    }

    func testCastRemoteData() throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)

        let fakeApiKey = UUID().uuidString
        let apiEndpoint = URL(string: "https://api.themoviedb.org/3/movie/566525/casts?api_key=\(fakeApiKey)")!

        let jsonData = try String(contentsOf: MockedData.movieCastsJSON).data(using: .utf8)
        let expectedData = try JSONDecoder().decode(CastResponse.self, from: jsonData!)
        let requestExpectation = expectation(description: "Request should finish")

        let mockedData = try! JSONEncoder().encode(expectedData)
        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        mock.register()

        sessionManager
            .request(apiEndpoint)
            .responseDecodable(of: CastResponse.self) { (response) in
                XCTAssertNotNil(response)

                switch response.result {
                case .success(let data):
                    XCTAssertNotNil(data)
                    requestExpectation.fulfill()
                case .failure(_):
                    XCTFail("Failure in result!")
                }
            }.resume()

        wait(for: [requestExpectation], timeout: 10.0)
    }

    func testDetailMapper() throws {
        let response = MovieDetail.fake()
        let model = MovieDetailMapper.mapMovieDetailToDomains(input: response)

        XCTAssertEqual(response.id, model.id)
        XCTAssertEqual(response.runtime, model.runtime)
        XCTAssertEqual(response.genres?.count ?? 0, model.genres?.count ?? 0)
        XCTAssertEqual(response.productionCompanies?.count ?? 0, model.productionCompanies?.count ?? 0)
        XCTAssertEqual(response.tagline, model.tagline)
        XCTAssertEqual(response.status, model.status)
    }

    func testCastMapper() throws {
        let response = CastResponse.fake()
        let model = CastMapper.mapCastResponsesToDomains(input: response)

        XCTAssertEqual(response.cast.count, model.count)
    }
}
// swiftlint:enable line_length force_try
