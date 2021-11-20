//
//  MoviePoster.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import SwiftUI

import CWSharedView
import CWMovie

struct MoviePoster: View {
    var movie: MovieModel
    var showReleaseYear = false

    var body: some View {
        HStack(alignment: .top) {
            PosterImage(imageUrl: movie.posterUrl)
                .padding(.trailing, 4)

            VStack(alignment: .leading) {
                HStack {
                    TextTitle(movie.title)

                    if showReleaseYear {
                        Spacer()

                        TextSubtitle(movie.releaseYearDate)
                    }
                }.padding(.bottom, 2)

                HStack {
                    TextBadge(movie.capitalLanguage)

                    if movie.isAdultRated {
                        TextBadge("Adult")
                    }
                }.padding(.bottom, 8)

                RatingView(movie.voteAverage)
                    .padding(.bottom)

                TextSubtitle(movie.overview)
                    .lineLimit(3)
            }

            Spacer()
        }
    }
}

struct MoviePoster_Previews: PreviewProvider {
    static var previews: some View {
        MoviePoster(movie: MovieModel.fake())

        MoviePoster(movie: MovieModel.fake(), showReleaseYear: true)
    }
}
