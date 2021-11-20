//
//  MovieBackdrop.swift
//  CineWatch
//
//  Created by Andika on 22/10/21.
//

import SwiftUI

import CWSharedView
import CWMovie

struct MovieBackdrop: View {
    var movie: MovieModel
    var fullsize: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            BackdropImage(imageUrl: movie.backdropUrl, fullsize: fullsize)

            TextSubtitle(movie.releaseYearDate)
                .padding(.top, 8)

            TextTitle(movie.title)

            TextSubtitle(movie.overview)
                .lineLimit(2)
                .padding(.top, 4)
        }.frame(width: fullsize ? nil : 300)
    }
}

struct MovieBackdrop_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdrop(movie: MovieModel.fake())
    }
}
