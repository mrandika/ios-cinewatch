//
//  SearchView.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import SwiftUI
import SwiftUIX
import CWMovie

public struct SearchView<Sheet: View>: View {
    @EnvironmentObject var searchPresenter: SearchPresenter
    @EnvironmentObject var popularPresenter: PopularPresenter

    var accountSheet: (() -> Sheet)

    @State var showAccountModal: Bool = false

    @State var keywords: String = ""
    @State var isSearching: Bool = false
    @State var isEditing: Bool = false

    public init(accountSheet: @escaping (() -> Sheet)) {
        self.accountSheet = accountSheet
    }

    public var body: some View {
        NavigationView {
            VStack {
                if !keywords.isEmpty {
                    SearchResultViewComponent(presenter: searchPresenter, query: keywords)
                } else {
                    PopularViewComponent(presenter: popularPresenter)
                }
            }.navigationSearchBar {
                SearchBar("Search...", text: $keywords.onChange(perform: { _ in
                    searchPresenter.fetchSearchResult(for: keywords)
                }), isEditing: $isEditing, onCommit: {
                    isSearching = true
                    searchPresenter.fetchSearchResult(for: keywords)
                }).onCancel {
                    isSearching = false
                }.showsCancelButton(isEditing)
            }.navigationTitle("SEARCH")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAccountModal.toggle()
                    }, label: {
                        Image(systemName: "person.circle")
                    })
                }
            }
        }.navigationSearchBarHiddenWhenScrolling(false)
            .sheet(isPresented: $showAccountModal, content: {
                accountSheet()
            })
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(accountSheet: {
            VStack {
                Text("Im in a sheet!")
            }
        })
            .environmentObject(SearchPresenter(searchUseCase: MovieInjection.init().provideSearch()))
            .environmentObject(PopularPresenter(popularUseCase: MovieInjection.init().providePopular()))
    }
}
