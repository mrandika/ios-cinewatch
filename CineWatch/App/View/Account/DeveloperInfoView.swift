//
//  DeveloperInfoView.swift
//  CineWatch
//
//  Created by Andika on 31/10/21.
//

import SwiftUI

struct DeveloperInfoView: View {
    var body: some View {
        List {
            Section(header: Text("PERSONAL_DETAILS")) {
                HStack {
                    Image("Account")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 128)
                        .clipShape(Circle())
                        .padding(.vertical)
                        .padding(.trailing)

                    VStack(alignment: .leading) {
                        Text("Muhammad Rizki Andika")
                            .bold()
                            .padding(.bottom, 8)

                        Text("Telkom University")
                    }
                }
            }
        }.listStyle(GroupedListStyle())
        .navigationBarTitle("DEVELOPER_INFO", displayMode: .inline)
    }
}

struct DeveloperInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperInfoView()
    }
}
