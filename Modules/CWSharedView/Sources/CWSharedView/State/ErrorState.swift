//
//  ErrorState.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import SwiftUI

import CWCommon

public struct ErrorState: View {
    var image: String
    var error: Error

    var showRetryButton: Bool = true
    var retryAction: () -> Void

    public init(image: String,
                error: Error,
                showRetryButton: Bool = true,
                retryAction: @escaping () -> Void) {
        self.image = image
        self.error = error
        self.showRetryButton = showRetryButton
        self.retryAction = retryAction
    }

    public var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 100)

            Text(error.localizedDescription)
                .foregroundColor(.systemGray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 32)

            if showRetryButton {
                Button(action: {
                    retryAction()
                }, label: {
                    SecondaryButton("TRY_AGAIN")
                })
            }
        }.padding()
    }
}

struct ErrorState_Previews: PreviewProvider {
    static var previews: some View {
        ErrorState(image: "State_Error", error: NetworkError.requestFail(with: 500), retryAction: {
            debugPrint("Retrying...")
        })
    }
}
