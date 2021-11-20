//
//  PrimaryButton.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import SwiftUI

public struct PrimaryButton: View {
    var text: String

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        Text(LocalizedStringKey(text))
            .font(.system(size: 14))
            .foregroundColor(.systemRed)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton("SHOW_ALL")
    }
}
