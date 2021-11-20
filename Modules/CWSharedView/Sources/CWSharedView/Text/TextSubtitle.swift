//
//  TextSubtitle.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import SwiftUI

public struct TextSubtitle: View {
    var subtitle: String

    public init(_ subtitle: String) {
        self.subtitle = subtitle
    }

    public var body: some View {
        Text(subtitle)
            .font(.system(size: 14))
            .foregroundColor(.systemGray)
    }
}

struct TextSubtitle_Previews: PreviewProvider {
    static var previews: some View {
        TextSubtitle("2021")
    }
}
