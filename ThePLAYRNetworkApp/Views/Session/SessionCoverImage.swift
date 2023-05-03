//
//  SessionCoverImage.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 4/4/23.
//

import SwiftUI


struct SessionCoverImage: View {
    @EnvironmentObject var coverImageViewModel: SessionCoverImageViewModel
    
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


 
