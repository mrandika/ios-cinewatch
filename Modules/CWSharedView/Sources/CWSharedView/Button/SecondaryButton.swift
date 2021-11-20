//
//  SecondaryButton.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import SwiftUI

public struct SecondaryButton: View {
    var text: String
    var image: String?

    public init(_ text: String, image: String? = nil) {
        self.text = text
        self.image = image
    }

    public var body: some View {
        HStack {
            if let image = image {
                Image(systemName: image)
                    .foregroundColor(.systemRed)
                    .padding(.trailing, 4)
            }

            Text(LocalizedStringKey(text))
                .font(.system(size: 14))
                .foregroundColor(.systemRed)
        }.padding(.vertical, 12)
            .padding(.horizontal, 22)
            .background(.systemRed.opacity(0.15))
            .cornerRadius(10)
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton("TRY_AGAIN")
        SecondaryButton("ADD", image: "plus")
    }
}
