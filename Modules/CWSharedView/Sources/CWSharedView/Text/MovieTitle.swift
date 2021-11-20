//
//  TextTitle.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import SwiftUI

public struct TextTitle: View {
    var title: String

    public init(_ title: String) {
        self.title = title
    }

    public var body: some View {
        Text(LocalizedStringKey(title))
            .font(.system(size: 18))
            .bold()
    }
}

struct TextTitle_Previews: PreviewProvider {
    static var previews: some View {
        TextTitle("Dune")
    }
}
