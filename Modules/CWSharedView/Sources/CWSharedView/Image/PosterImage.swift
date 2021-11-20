//
//  PosterImage.swift
//  CineWatch
//
//  Created by Andika on 21/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

public struct PosterImage: View {
    var imageUrl: URL

    var fullsize: Bool
    var maxWidth: CGFloat

    public init(imageUrl: URL, fullsize: Bool = false, maxWidth: CGFloat = 100) {
        self.imageUrl = imageUrl
        self.fullsize = fullsize
        self.maxWidth = maxWidth
    }

    public var body: some View {
        WebImage(url: imageUrl)
            .placeholder {
                Image("State_PosterEmpty")
                    .resizable()
                    .scaledToFit()
                    .frame(width: fullsize ? nil : maxWidth)
                    .cornerRadius(5)
            }.resizable()
            .renderingMode(.original)
            .scaledToFit()
            .frame(maxWidth: fullsize ? nil : maxWidth)
            .cornerRadius(5)
    }
}

struct PosterImage_Previews: PreviewProvider {
    static var previews: some View {
        PosterImage(imageUrl: URL(string: "https://image.tmdb.org/t/p/w500/lr3cYNDlJcpT1EWzFH42aSIvkab.jpg")!)
    }
}
