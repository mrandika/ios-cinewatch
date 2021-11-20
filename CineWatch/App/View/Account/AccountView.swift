//
//  AccountView.swift
//  CineWatch
//
//  Created by Andika on 18/11/21.
//

import SwiftUI

import CWMoviePage
import CWGenrePage

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var genrePresenter: GenrePresenter
    @EnvironmentObject var discoverPresenter: DiscoverPresenter
    @EnvironmentObject var watchlistPresenter: WatchlistPresenter

    @State var showAlert: Bool = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("MY_ACCOUNT")) {
                    NavigationLink(
                        destination: WatchlistView(),
                        label: {
                            Text("🎞 \(Text("WATCH_LIST"))")
                        })

                    NavigationLink(
                        destination: GenreSelectionView(onUpdate: {
                            discoverPresenter.fetchDiscovery()
                        }, onReset: {
                            discoverPresenter.fetchDiscovery()
                        }),
                        label: {
                            Text("🎬 \(Text("GENRE"))")
                        })
                }

                Section(header: Text("GENERAL")) {
                    NavigationLink(
                        destination: LicenseView(),
                        label: {
                            Text("👩🏻‍⚖️ \(Text("SOFTWARE_LICENSE"))")
                        })

                    NavigationLink(
                        destination: DeveloperInfoView(),
                        label: {
                            Text("👨🏻‍💻 \(Text("MEET_THE_DEVELOPER"))")
                        })
                }

                Section {
                    Button(action: {
                        showAlert.toggle()
                    }, label: {
                        HStack {
                            Text("CLEAR_WATCHLIST")
                                .foregroundColor(.systemRed)
                        }
                    })
                }
            }.listStyle(GroupedListStyle())
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("ALERT_CLEAR_WATCHLIST"),
                      message: Text("ALERT_CLEAR_WATCHLIST_DESCRIPTION"),
                      primaryButton: .destructive(Text("ACTION_CONFIRM"),
                                                  action: {
                    watchlistPresenter.clearWatchlist()
                    presentationMode.wrappedValue.dismiss()
                    }), secondaryButton: .cancel(Text("ACTION_CANCEL")))
                })
            .navigationBarTitle("ACCOUNT", displayMode: .inline)
        }.accentColor(.systemRed)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
