//
//  RatingView.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import SwiftUI

public struct RatingView: View {
    var rating: Double

    public init(_ rating: Double) {
        self.rating = rating
    }

    public var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 14)
                .foregroundColor(.systemYellow)

            Text("\(rating, specifier: "%.1f")")
                .font(.system(size: 12))
                .foregroundColor(.systemGray)
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(1.0)
        RatingView(2.0)
        RatingView(3.0)
        RatingView(4.0)
        RatingView(5.0)
    }
}
