//
//  OnboardingView.swift
//  CineWatch
//
//  Created by Andika on 29/10/21.
//

import SwiftUI
import CWGenrePage

struct OnboardingView: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(alignment: .center) {
            ScrollView(showsIndicators: false) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.vertical)

                Text(LocalizedStringKey("WELCOME_TEXT"))
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 32)
                    .multilineTextAlignment(.center)

                VStack(alignment: .leading) {
                    OnboardingCell(image: "play.tv.fill",
                                   imageColor: .systemRed,
                                   title: "ONBOARDING_NOW_PLAYING",
                                   description: "ONBOARDING_NOW_PLAYING_DESCRIPTION")

                    OnboardingCell(image: "calendar.badge.clock",
                                   imageColor: .systemIndigo,
                                   title: LocalizedStringKey("ONBOARDING_UPCOMING"),
                                   description: LocalizedStringKey("ONBOARDING_UPCOMING_DESCRIPTION"))

                    OnboardingCell(image: "list.triangle",
                                   imageColor: .systemTeal,
                                   title: LocalizedStringKey("ONBOARDING_WATCHLIST"),
                                   description: LocalizedStringKey("ONBOARDING_WATCHLIST_DESCRIPTION"))

                    OnboardingCell(image: "magnifyingglass",
                                   imageColor: .systemGreen,
                                   title: LocalizedStringKey("ONBOARDING_SEARCH"),
                                   description: LocalizedStringKey("ONBOARDING_SEARCH_DESCRIPTION"))
                }
            }

            Spacer()

            Button(action: {
                appState.passOnboarding()
                presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Spacer()

                    Text("NEXT")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.vertical, 2)

                    Spacer()
                }.padding()
                .background(Color(UIColor.systemRed))
                .cornerRadius(10)
            }).padding(.vertical)
                .navigationBarHidden(true)
        }
        .padding(.horizontal, 32)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(AppState())
    }
}

struct OnboardingCell: View {
    var image: String
    var imageColor: Color

    var title: LocalizedStringKey
    var description: LocalizedStringKey

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: image)
                .renderingMode(.template)
                .font(.system(size: 32))
                .foregroundColor(imageColor)
                .frame(maxWidth: 50)
                .padding(.bottom)
                .padding(.trailing)

            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                    .padding(.bottom, 1)

                Text(description)
                    .font(.body)
            }
        }.padding(.bottom, 32)
    }
}
