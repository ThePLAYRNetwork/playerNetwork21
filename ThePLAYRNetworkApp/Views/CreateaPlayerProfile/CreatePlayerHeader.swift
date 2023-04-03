//
//  CreatePlayerHeader.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 3/21/23.
//

import SwiftUI

struct CreatePlayerHeader: View {
    
    
    var body: some View {
        
        HStack {
            Image("onboardingLogo")
                .resizable()
                .frame(width:83, height: 68)
                .padding(.top, 45)
            Spacer()
            CircularProfileImageSmall()
                .padding(.top, 45)
        }
        .padding(.top, 45)
        .padding(.horizontal)
        .frame(height: 147)
        .background(Color.ui.black)
        .clipShape(RoundedShape(corners: [.bottomRight]))
        .clipShape(RoundedShape(corners: [.bottomLeft]))
    }
}

struct CircularProfileImageSmall: View {
    @EnvironmentObject var ckUserViewModel: CloudKitUserViewModel

    var body: some View {
        ProfileImageSmall()
            .frame(width: 36, height: 36)
            .clipShape(Circle())
            .background {
                Circle().fill(Color.ui.grayD9D9D9)
            }
    }
}

struct ProfileImageSmall: View {
    @EnvironmentObject var ckUserViewModel: CloudKitUserViewModel
    
    var body: some View {
        switch ckUserViewModel.imageState {
        case .success(let data):
            if let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable().scaledToFill()
            }
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "person.fill")
                .font(.system(size: 20))
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 20))
                .foregroundColor(.white)
        }
    }
}


struct CreatePlayerHeader_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlayerHeader()
    }
}

