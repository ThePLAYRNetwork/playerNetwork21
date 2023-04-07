//
//  CoverImage.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 4/4/23.
//

import SwiftUI


struct CoverImage: View {
    @EnvironmentObject var coverImageViewModel: CoverImageViewModel
    
    var body: some View {
        

            
            if let image = coverImageViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(height: 212)
                    .padding()
                    .padding(.bottom, 20)
                
            } else {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .foregroundColor(Color.ui.grayF6F6F6)
                
                    .frame(height: 212)
                    .padding()
                    .padding(.bottom, 20)
            }
            
        
            
            
    
        
        
    }
}


