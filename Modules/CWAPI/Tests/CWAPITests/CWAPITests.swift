import XCTest
@testable import CWAPI

final class CWAPITests: XCTestCase {
    func testApiKey() throws {
        XCTAssertNoThrow(API.apiKey)
        XCTAssertNotNil(API.apiKey)
    }

    func testEndpointUrl() throws {
        XCTAssertEqual(Endpoints.Get.discover.url, "https://api.themoviedb.org/3/discover/movie")
        XCTAssertEqual(Endpoints.Get.nowPlaying.url, "https://api.themoviedb.org/3/movie/now_playing")
        XCTAssertEqual(Endpoints.Get.upcoming.url, "https://api.themoviedb.org/3/movie/upcoming")
        XCTAssertEqual(Endpoints.Get.popular.url, "https://api.themoviedb.org/3/movie/popular")
        XCTAssertEqual(Endpoints.Get.detail.url, "https://api.themoviedb.org/3/movie/")
        XCTAssertEqual(Endpoints.Get.search.url, "https://api.themoviedb.org/3/search/movie")
    }
}
