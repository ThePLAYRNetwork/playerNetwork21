//
//  CreatePlayerProfileView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 12/13/22.
//
// ***** THIS VIEW IS NOT USED YET, AND MIGHT NOT BE
import SwiftUI
import _PhotosUI_SwiftUI

struct CreatePlayerProfileView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var ckUserViewModel: CloudKitUserViewModel
    //    @State var user = User()
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack {
                    Image("onboardingLogo")
                        .resizable()
                        .frame(width: 83, height: 68)
                        .padding(.top, 30)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 60)
                
                VStack(alignment: .center) {
                    CircularProfileImage()
                        .overlay(alignment: .bottomTrailing) {
                            PhotosPicker(selection: $ckUserViewModel.imageSelection, matching: .images, photoLibrary: .shared()) {
                                Image(systemName: "pencil.circle.fill")
                                    .symbolRenderingMode(.multicolor)
                                    .font(.system(size: 30))
                                    .foregroundColor(.accentColor)
                            }
                            .buttonStyle(.borderless)
                        }
                    
                    Text("Choose a Profile Photo")
                        .font(.system(size: 12))
                        .foregroundColor(Color.ui.grayD9D9D9)
                        .padding(.bottom)
                }
            }
            .padding(.bottom)
            .frame(height: 300)
            .background(Color.ui.black)
            .clipShape(RoundedShape(corners: [.bottomRight]))
            .clipShape(RoundedShape(corners: [.bottomLeft]))
            
            HStack{
                VStack(alignment: .leading){
                    Text("FIRST NAME")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.black)
                    
                    TextField(
                        "John", text: $ckUserViewModel.user.firstName
                    )
                    .padding()
                    .frame(width:184, height: 50)
                    .background(Color.ui.grayF6F6F6)
                    .cornerRadius(10)
                }
                
                
                VStack(alignment: .leading){
                    Text("LAST NAME")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.black)
                    
                    TextField(
                        "Doe", text: $ckUserViewModel.user.lastName
                    )
                    .padding()
                    .frame(width:184, height: 50)
                    .background(Color.ui.grayF6F6F6)
                    .cornerRadius(10)
                }
                
            }
            .padding(.vertical, 20)
            
            VStack(alignment: .leading){
                Text("EMAIL")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.black)
                
                TextField(
                    "example@gmail.com", text: $ckUserViewModel.user.email
                )
                .padding()
                .frame(width:378, height: 50)
                .background(Color.ui.grayF6F6F6)
                .cornerRadius(10)
                
            }
            .padding(.bottom, 20)
            
            
            VStack(alignment: .leading){
                Text("PHONE NUMBER")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.black)
                
                TextField(
                    "(   )  -", text: $ckUserViewModel.user.phoneNumber
                )
                .padding()
                .frame(width:378, height: 50)
                .background(Color.ui.grayF6F6F6)
                .cornerRadius(10)
            }
            .padding(.bottom, 20)
            
            Spacer()
            
            Button {
                navigationModel.path.append(OnboardingDestination.role)
            } label: {
                Text("Continue")
                    .foregroundColor(.white)
                    .frame(width:226, height: 48)
                    .background(Color.ui.accentColor)
                    .cornerRadius(34)
                    .padding(.bottom, 45)
            }
            .disabled(isDisabled())
            .opacity(isDisabled() ? 0.5 : 1.0)
        }
        .ignoresSafeArea()
        .task {
            await ckUserViewModel.getPlayerStyles()
        }
    }
    
    private func isDisabled() -> Bool {
        return ckUserViewModel.user.firstName.isEmpty || ckUserViewModel.user.lastName.isEmpty || ckUserViewModel.user.email.isEmpty
    }
}

struct CircularProfileImage: View {
    @EnvironmentObject var ckUserViewModel: CloudKitUserViewModel
    
    var body: some View {
        ProfileImage()
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            .background {
                Circle().fill(Color.ui.grayD9D9D9)
            }
    }
}

struct ProfileImage: View {
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
                .font(.system(size: 50))
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.white)
        }
    }
}

//struct CreatePlayerProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatePlayerProfileView(user: User.sampleUsers[0])
//    }
//}





