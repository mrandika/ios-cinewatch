//
//  BackdropImage.swift
//  CineWatch
//
//  Created by Andika on 21/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

public struct BackdropImage: View {
    var imageUrl: URL

    var fullsize: Bool
    var enableBorder: Bool
    var width: CGFloat

    public init(imageUrl: URL, fullsize: Bool = false, enableBorder: Bool = true, width: CGFloat = 300) {
        self.imageUrl = imageUrl
        self.fullsize = fullsize
        self.enableBorder = enableBorder
        self.width = width
    }

    public var body: some View {
        WebImage(url: imageUrl)
            .placeholder {
                Image("State_BackdropEmpty")
                    .resizable()
                    .scaledToFit()
                    .frame(width: !fullsize ? width : nil)
                    .cornerRadius(enableBorder ? 5 : 0)
            }.resizable()
            .renderingMode(.original)
            .scaledToFit()
            .frame(width: !fullsize ? width : nil)
            .cornerRadius(enableBorder ? 5 : 0)
    }
}

// swiftlint:disable line_length
struct BackdropImage_Previews: PreviewProvider {
    static var previews: some View {
        BackdropImage(imageUrl: URL(string: "https://image.tmdb.org/t/p/w780/x6E7DS5ZcMoCITjkO0RiLLQ9Nb0.jpg")!)
        BackdropImage(imageUrl: URL(string: "https://image.tmdb.org/t/p/w780/x6E7DS5ZcMoCITjkO0RiLLQ9Nb0.jpg")!, fullsize: true)
    }
}
// swiftlint:enable line_length
