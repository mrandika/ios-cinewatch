//
//  CastComponent.swift
//  CineWatch
//
//  Created by Andika on 28/10/21.
//

import SwiftUI

import CWMovieDetail
import CWSharedView

struct CastComponent: View {
    var cast: CastModel

    var body: some View {
        HStack(alignment: .top) {
            CastImage(imageUrl: cast.profileUrl)
                .padding(.trailing, 4)

            VStack(alignment: .leading) {
                TextTitle(cast.name)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 2)

                TextSubtitle(cast.characterAs)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
        }
    }
}

struct CastComponent_Previews: PreviewProvider {
    static var previews: some View {
        CastComponent(cast: CastModel.fake())
    }
}
