//
//  StateContainer.swift
//  CineWatch
//
//  Created by Andika on 25/10/21.
//

import SwiftUI

import CWCommon

public struct StateContainer<Content: View>: View {
    @Binding var isLoading: Bool
    @Binding var isError: Bool
    var error: Error

    var content: () -> Content
    var onRetry: () -> Void

    public init(isLoading: Binding<Bool>,
                isError: Binding<Bool>,
                error: Error,
                content: @escaping () -> Content,
                onRetry: @escaping () -> Void) {
        self._isLoading = isLoading
        self._isError = isError
        self.error = error
        self.content = content
        self.onRetry = onRetry
    }

    public var body: some View {
        if isLoading && !isError {
            LoadingState()
        } else if isError {
            ErrorState(image: "State_Error", error: error, retryAction: onRetry)
        } else {
            content()
        }
    }
}

// swiftlint:disable line_length
struct StateContainer_Previews: PreviewProvider {
    static var previews: some View {
        StateContainer(isLoading: .constant(false), isError: .constant(false), error: NetworkError.requestFail(with: 500), content: {
            VStack {
                Text("Hello World!")
            }
        }, onRetry: {

        })

        StateContainer(isLoading: .constant(true), isError: .constant(false), error: NetworkError.requestFail(with: 500), content: {
            VStack {
                Text("Hello World!")
            }
        }, onRetry: {

        })

        StateContainer(isLoading: .constant(false), isError: .constant(true), error: NetworkError.requestFail(with: 500), content: {
            VStack {
                Text("Hello World!")
            }
        }, onRetry: {

        })
    }
}
// swiftlint:enable line_length
