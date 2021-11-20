//
//  MovieDetailView.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

import CWSharedView
import CWMovie
import CWMovieDetail
import CWMovieWatchlist

public struct MovieDetailView: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var watchlistPresenter: DetailWatchlistPresenter

    @ObservedObject var presenter: MovieDetailPresenter
    @ObservedObject var castPresenter: CastPresenter

    @State var showAllCasts: Bool = false

    var movie: MovieModel
    var showShareToolbar: Bool

    public init(presenter: MovieDetailPresenter,
                castPresenter: CastPresenter,
                movie: MovieModel, showShareToolbar: Bool = true) {
        self.presenter = presenter
        self.castPresenter = castPresenter
        self.movie = movie
        self.showShareToolbar = showShareToolbar
    }

    public var body: some View {
        VStack {
            StateContainer(isLoading: $presenter.isLoading,
                           isError: $presenter.isError,
                           error: presenter.error, content: {
                ScrollView {
                    BackdropImage(imageUrl: movie.higherResolutionBackdropUrl,
                                  fullsize: true, enableBorder: false)
                        .padding(.bottom)

                    VStack(alignment: .leading) {
                        MovieHeader(movie, presenter: presenter, onRemove: {
                            watchlistPresenter.fetchWatchlist()
                            presentationMode.wrappedValue.dismiss()
                        }).fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom)

                        if let genres = presenter.movie.genreText, !genres.isEmpty {
                            MovieCompactDataCell(title: "GENRES".localized(), value: genres)
                                .padding(.bottom, 8)
                        }

                        MovieCompactDataCell(title: "RUNTIME".localized(),
                                             value: presenter.movie.runtimeFormatted)
                            .padding(.bottom, 8)

                        MovieCompactDataCell(title: "RELEASE_DATE".localized(),
                                             value: movie.releaseCompleteDate)
                            .padding(.bottom)

                        if let overview = movie.overview, !overview.isEmpty {
                            MovieDataCell(title: "ABOUT_THIS_MOVIE".localized(), value: overview)
                                .padding(.bottom)
                        }

                        if let casts = castPresenter.casts, !casts.isEmpty {
                            HStack(alignment: .center) {
                                TextTitle("CASTS".localized())

                                Spacer()

                                Button(action: {
                                    withAnimation {
                                        showAllCasts.toggle()
                                    }
                                }, label: {
                                    PrimaryButton(showAllCasts ?
                                                  "SHOW_LESS".localized() :
                                                    "SHOW_ALL".localized()
                                    )
                                })
                            }.padding(.bottom, 4)

                            ForEach(casts.prefix(showAllCasts ? 10 : 5), id: \.id) { cast in
                                CastComponent(cast: cast)
                                    .padding(.vertical, 4)
                            }.padding(.bottom)
                        }

                        if let productionHouse = presenter.movie.productionCompanyText,
                            !productionHouse.isEmpty {
                            MovieDataCell(title: "PRODUCTION_HOUSE".localized(), value: productionHouse)
                                .padding(.bottom)
                        }
                    }.padding([.bottom, .horizontal])
                }
            }, onRetry: {
                presenter.fetchMovieDetail(id: movie.id)
            })
        }.toolbar {
            #if canImport(UIKit)
            ToolbarItem(placement: .navigationBarTrailing) {
                if showShareToolbar {
                    Button(action: {
                        shareSheet()
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                    })
                }
            }
            #endif
        }.onAppear {
            if movie.id != presenter.movie.id && !presenter.isError {
                presenter.fetchMovieDetail(id: movie.id)
            }

            watchlistPresenter.isMovieOnWatchlist(movie: movie)
            castPresenter.fetchCasts(id: movie.id)
        }.navigationTitle("MOVIE_DETAIL".localized())
        #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    #if canImport(UIKit)
    // swiftlint:disable line_length
    private func shareSheet() {
        let text = "\(String(format: NSLocalizedString("SHARE_SHEET_TEXT %@", comment: ""), movie.title)) \nhttps://www.themoviedb.org/movie/\(movie.id)"
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    // swiftlint:enable line_length
    #endif
}

struct MovieHeader: View {
    @EnvironmentObject var watchlistPresenter: DetailWatchlistPresenter
    @ObservedObject var presenter: MovieDetailPresenter
    @State var showRemovingAlert = false

    var movie: MovieModel
    var onRemove: () -> Void

    init(_ movie: MovieModel, presenter: MovieDetailPresenter, onRemove: @escaping () -> Void) {
        self.movie = movie
        self.presenter = presenter
        self.onRemove = onRemove
    }

    var body: some View {
        HStack(alignment: .top) {
            PosterImage(imageUrl: movie.posterUrl)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.trailing, 12)

            VStack(alignment: .leading) {
                HStack {
                    TextTitle(movie.title)
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer()

                    RatingView(movie.voteAverage)
                        .padding(.leading)
                }

                if let tagline = presenter.movie.tagline, !tagline.isEmpty {
                    Text(tagline)
                        .font(.system(size: 12))
                        .foregroundColor(.systemGray)
                        .italic()
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 8)
                }

                HStack {
                    TextBadge(movie.capitalLanguage)

                    if movie.isAdultRated {
                        TextBadge("Adult")
                    }
                }.padding(.bottom, 8)

                HStack {
                    Spacer()

                    Button(action: {
                        if watchlistPresenter.isMovieOnWatchlist {
                            showRemovingAlert.toggle()
                        } else {
                            watchlistPresenter.addToWatchlist(movie: movie)
                        }
                    }, label: {
                        SecondaryButton(
                            watchlistPresenter.isMovieOnWatchlist ?
                            "REMOVE_WATCHLIST".localized() :
                                "ADD_WATCHLIST".localized(),
                            image: watchlistPresenter.isMovieOnWatchlist ? "minus" : "plus")
                    })
                }.padding(.top)
            }
        }.alert(isPresented: $showRemovingAlert, content: {
            Alert(title: Text("ALERT_REMOVE_WATCHLIST".localized()),
                  message: Text("ALERT_REMOVE_WATCHLIST_DESCRIPTION".localized()),
                  primaryButton: .cancel(Text("ACTION_CANCEL")),
                  secondaryButton: .destructive(Text("ACTION_CONFIRM"), action: {
                watchlistPresenter.removeFromWatchlist(movie: movie)
                onRemove()
            })
            )
        })
    }
}

struct MovieCompactDataCell: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            TextTitle(title)

            Spacer()

            TextSubtitle(value)
        }
    }
}

struct MovieDataCell: View {
    var title: String
    var value: String

    var body: some View {
        VStack(alignment: .leading) {
            TextTitle(title)
                .padding(.bottom, 4)

            TextSubtitle(value)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

// swiftlint:disable line_length
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(
            presenter: MovieDetailPresenter(detailUseCase: MovieDetailInjection.init().provideDetail(), watchlistUseCase: MovieWatchlistInjection.init().provideWatchlist()),
            castPresenter: CastPresenter(castUseCase: CastInjection.init().provideCast()),
            movie: MovieModel.fake())
    }
}
// swiftlint:enable line_length
