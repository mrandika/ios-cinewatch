//
//  LoadingState.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import SwiftUI
import SwiftUIX

public struct LoadingState: View {
    public var title: String

    public init(title: String = "LOADING") {
        self.title = title
    }

    public var body: some View {
        VStack {
            ActivityIndicator()
                .padding(.bottom, 10)

            Text(LocalizedStringKey(title))
                .font(.callout)
                .foregroundColor(.systemGray)
        }
    }
}

struct LoadingState_Previews: PreviewProvider {
    static var previews: some View {
        LoadingState()
    }
}
