import XCTest
import Alamofire
import Mocker
@testable import CWMovieGenre

// swiftlint:disable force_try
final class CWMovieGenreTests: XCTestCase {
    func testRemoteData() throws {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)

        let fakeApiKey = UUID().uuidString
        let apiEndpoint = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(fakeApiKey)")!

        let jsonData = try String(contentsOf: MockedData.genresJSON).data(using: .utf8)
        let expectedData = try JSONDecoder().decode(GenreResponse.self, from: jsonData!)
        let requestExpectation = expectation(description: "Request should finish")

        let mockedData = try! JSONEncoder().encode(expectedData)
        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        mock.register()

        sessionManager
            .request(apiEndpoint)
            .responseDecodable(of: GenreResponse.self) { (response) in
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

    func testGenreMapper() throws {
        let response = GenreResponse.fake()
        let model = GenreMapper.mapGenreResponsesToDomains(input: response)

        XCTAssertEqual(response.genres.count, model.count)
    }
}
// swiftlint:enable force_try
