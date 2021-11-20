import XCTest
import Combine
@testable import CWMovieWatchlist

// swiftlint:disable line_length
final class CWMovieWatchlistTests: XCTestCase {

    private var canceallable: Set<AnyCancellable> = []
    private let watclistInjection = MovieWatchlistInjection()

    private let watchlistExamples = [
        WatchlistModel(id: 1, posterPath: "FAKE", backdropPath: "FAKE", isAdultRated: false, overview: "FAKE", releaseDate: nil, title: "FAKE 1", language: "FAKE", voteAverage: 7.9),
        WatchlistModel(id: 2, posterPath: "FAKE", backdropPath: "FAKE", isAdultRated: false, overview: "FAKE", releaseDate: nil, title: "FAKE 2", language: "FAKE", voteAverage: 8.2),
        WatchlistModel(id: 3, posterPath: "FAKE", backdropPath: "FAKE", isAdultRated: false, overview: "FAKE", releaseDate: nil, title: "FAKE 3", language: "FAKE", voteAverage: 6.4)
    ]

    func testAddToDatabase() throws {
        let interactor = watclistInjection.provideWatchlist()
        var isSuccess: Bool = false

        interactor.addToWatchlist(movie: watchlistExamples[0])
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    isSuccess = false
                case .finished:
                    isSuccess = true
                }
            }, receiveValue: { data in
                XCTAssertTrue(data == true && isSuccess)
            }).store(in: &canceallable)
    }

    func testDatabaseList() throws {
        let interactor = watclistInjection.provideWatchlist()
        var isSuccess: Bool = false

        interactor.getWatchlist()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    isSuccess = false
                case .finished:
                    isSuccess = true
                }
            }, receiveValue: { data in
                XCTAssertTrue(isSuccess)
                XCTAssertNotEqual(data.count, 0)
            }).store(in: &canceallable)
    }

    func testRemoveFromDatabase() throws {
        let interactor = watclistInjection.provideWatchlist()
        var isSuccess: Bool = false

        interactor.removeFromWatchlist(movie: watchlistExamples[0])
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    isSuccess = false
                case .finished:
                    isSuccess = true
                }
            }, receiveValue: { data in
                XCTAssertTrue(data == true && isSuccess)
            }).store(in: &canceallable)
    }

    func testCheckMovieOnDatabase() throws {
        let interactor = watclistInjection.provideWatchlist()
        var isSuccess: Bool = false

        interactor.isMovieOnWatchlist(movie: watchlistExamples[2])
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    isSuccess = false
                case .finished:
                    isSuccess = true
                }
            }, receiveValue: { data in
                XCTAssertTrue(data == false && isSuccess)
            }).store(in: &canceallable)
    }

    func testResetDatabase() throws {
        let interactor = watclistInjection.provideWatchlist()
        var isSuccess: Bool = false

        interactor.clearWatchlist()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    isSuccess = false
                case .finished:
                    isSuccess = true
                }
            }, receiveValue: { data in
                XCTAssertTrue(data == true && isSuccess)
            }).store(in: &canceallable)
    }
}
// swiftlint:enable line_length
