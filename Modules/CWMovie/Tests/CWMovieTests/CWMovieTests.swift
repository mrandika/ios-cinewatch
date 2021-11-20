import XCTest
import Alamofire
@testable import Mocker
@testable import CWMovie

// swiftlint:disable line_length force_try
final class CWMovieTests: XCTestCase {
    func testRemoteData() throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)

        let fakeApiKey = UUID().uuidString
        let apiEndpoint = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(fakeApiKey)&page=1")!

        let jsonData = try String(contentsOf: MockedData.moviesJSON).data(using: .utf8)
        let expectedData = try JSONDecoder().decode(MovieResponse.self, from: jsonData!)
        let requestExpectation = expectation(description: "Request should finish")

        let mockedData = try! JSONEncoder().encode(expectedData)
        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        mock.register()

        sessionManager
            .request(apiEndpoint)
            .responseDecodable(of: MovieResponse.self) { (response) in
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

    func testMovieMapper() throws {
        let response = MovieResponse.fake()
        let model = MovieMapper.mapMovieResponsesToDomains(input: response)

        XCTAssertEqual(response.results.count, model.count)
    }
}
// swiftlint:enable line_length force_try
