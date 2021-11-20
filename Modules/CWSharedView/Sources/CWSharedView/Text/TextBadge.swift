//
//  TextBadge.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import SwiftUI

public struct TextBadge: View {
    var content: String

    public init(_ content: String) {
        self.content = content
    }

    public var body: some View {
        Text(content)
            .font(.system(size: 9))
            .foregroundColor(.systemGray)
            .padding(2)
            .frame(maxWidth: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.systemGray.opacity(0.5), lineWidth: 1)
            )
    }
}

struct TextBadge_Previews: PreviewProvider {
    static var previews: some View {
        TextBadge("EN")
    }
}
