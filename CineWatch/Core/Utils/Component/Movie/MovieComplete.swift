//
//  MovieComplete.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import SwiftUI

import CWSharedView
import CWMovie

struct MovieComplete: View {
    var movie: MovieModel

    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                BackdropImage(imageUrl: movie.backdropUrl, fullsize: true)

                HStack(alignment: .bottom) {
                    PosterImage(imageUrl: movie.posterUrl)
                        .padding(.trailing, 8)

                    VStack(alignment: .leading) {
                        TextSubtitle(movie.releaseYearDate)
                            .padding(.bottom, 2)

                        TextTitle(movie.title)
                    }
                }.padding(.vertical, -75)
                .padding(.leading)
            }
        }
    }
}

struct MovieComplete_Previews: PreviewProvider {
    static var previews: some View {
        MovieComplete(movie: MovieModel.fake())
    }
}
