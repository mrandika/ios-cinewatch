//
//  CastImage.swift
//  CineWatch
//
//  Created by Andika on 22/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

public struct CastImage: View {
    var imageUrl: URL

    public init(imageUrl: URL) {
        self.imageUrl = imageUrl
    }

    public var body: some View {
        WebImage(url: imageUrl)
            .placeholder {
                Image("State_PosterEmpty")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(5)
                    .frame(height: 100)
            }.resizable()
            .renderingMode(.original)
            .scaledToFit()
            .cornerRadius(5)
            .frame(height: 100)
    }
}

struct CastImage_Previews: PreviewProvider {
    static var previews: some View {
        CastImage(imageUrl: URL(string: "https://image.tmdb.org/t/p/w185/8jNFfNmqHVqLHnGnxgu7y8xgRIa.jpg")!)
    }
}
