//
//  LicenseView.swift
//  CineWatch
//
//  Created by Andika on 31/10/21.
//

import SwiftUI

// swiftlint:disable line_length
struct LicenseView: View {
    var body: some View {
        List {
            LicenseDataView(name: "Alamofire", license: "MIT License", url: "https://github.com/Alamofire/Alamofire", description: "Elegant HTTP Networking in Swift")

            LicenseDataView(name: "realm-cocoa", license: "Apache License", url: "https://github.com/realm/realm-cocoa", description: "Realm is a mobile database: a replacement for Core Data & SQLite")

            LicenseDataView(name: "SDWebImageSwiftUI", license: "MIT License", url: "https://github.com/SDWebImage/SDWebImageSwiftUI", description: "This library provides an async image downloader with cache support. The framework provide the different View structs, which API match the SwiftUI framework guideline. If you're familiar with Image, you'll find it easy to use WebImage and AnimatedImage.")

            LicenseDataView(name: "SwiftUIX", license: "MIT License", url: "https://github.com/SwiftUIX/SwiftUIX", description: "SwiftUIX attempts to fill the gaps of the still nascent SwiftUI framework, providing an extensive suite of components, extensions and utilities to complement the standard library. This project is by far the most complete port of missing UIKit/AppKit functionality, striving to deliver it in the most Apple-like fashion possible.")
        }.navigationBarTitle("LICENSES", displayMode: .inline)
    }
}
// swiftlint:enable line_length

struct LicenseView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseView()
    }
}

struct LicenseDataView: View {

    var name: String
    var license: String
    var url: String
    var description: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(name)
                    .font(.title2)
                    .bold()

                Spacer()

                Text(license)
            }.padding(.bottom, 1)

            Text(url)
                .font(.system(size: 14))
                .foregroundColor(.blue)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 4)
                .fixedSize(horizontal: false, vertical: true)

            Text(description)
                .font(.body)
                .foregroundColor(.systemGray)
        }.padding(.vertical)
    }
}
