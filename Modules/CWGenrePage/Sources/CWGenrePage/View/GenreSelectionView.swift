//
//  GenreSelectionView.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import SwiftUI

import CWSharedView
import CWMovieGenre

public struct GenreSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var presenter: GenrePresenter

    var onUpdate: (() -> Void)
    var onReset: (() -> Void)

    public init(onUpdate: @escaping (() -> Void), onReset: @escaping (() -> Void)) {
        self.onUpdate = onUpdate
        self.onReset = onReset
    }

    public var body: some View {
        VStack {
            Text("GENRE_SELECTION".localized())
                .font(.title)
                .bold()
                .padding(.bottom, 8)
                .multilineTextAlignment(.center)

            Text("GENRE_SELECTION_DESCRIPTION".localized())
                .font(.body)
                .foregroundColor(.systemGray)
                .multilineTextAlignment(.center)
                .padding(.bottom)

            Spacer()

            StateContainer(isLoading: $presenter.isLoading,
                           isError: $presenter.isError,
                           error: presenter.error, content: {
                ScrollView {
                    ForEach(presenter.genres, id: \.id) { genre in
                        VStack {
                            HStack {
                                Text(genre.name)

                                Spacer()

                                Image(systemName:
                                        presenter.isGenreSelected(id: genre.id) ?
                                      "checkmark.circle.fill" : "circle")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 23)
                                    .foregroundColor(.systemRed)
                            }

                            Divider()
                        }.padding()
                        .onTapGesture {
                            presenter.genre = genre.id

                            onUpdate()
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }, onRetry: {
                presenter.fetchGenres()
            })

            Spacer()

            Button(action: {
                presenter.genre = nil
                onReset()
            }, label: {
                HStack {
                    Spacer()

                    Text("RESET_SELECTION".localized())

                    Spacer()
                }
            }).padding()
            .foregroundColor(.systemRed)
            .background(Color.systemRed.opacity(0.25))
            .cornerRadius(10)
        }.padding()
        .onAppear {
            if presenter.genres.isEmpty {
                presenter.fetchGenres()
            }
        }
    }
}

struct GenreSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenreSelectionView(onUpdate: {
            debugPrint("I'm updated!")
        }, onReset: {
            debugPrint("I'm resetted!")
        })
    }
}
