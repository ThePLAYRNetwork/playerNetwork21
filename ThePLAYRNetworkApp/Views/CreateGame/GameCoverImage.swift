//
//  GameCoverImage.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 5/1/23.
//

import SwiftUI

struct GameCoverImage: View {
    @EnvironmentObject var coverImageViewModel: GameCoverImageViewModel
    
    var body: some View {

                if let image = coverImageViewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                      .frame(height: 212)
                      
                      .cornerRadius(8)
                } else {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .foregroundColor(Color.ui.grayF6F6F6)
                        .frame(height: 212)

                }

    }
}

