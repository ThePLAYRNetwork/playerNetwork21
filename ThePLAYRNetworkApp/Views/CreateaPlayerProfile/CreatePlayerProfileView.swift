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
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    // https://developer.apple.com/documentation/swiftui/view/focused(_:)
    @FocusState private var emailFieldIsFocused: Bool
    @FocusState private var phoneFieldIsFocused: Bool
    @State private var invalidEmail = false
    @State private var invalidPhone = false

    
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
                            PhotosPicker(selection: $onboardingViewModel.imageSelection, matching: .images, photoLibrary: .shared()) {
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
                        "John", text: $onboardingViewModel.newUser.firstName
                    )
                    .autocorrectionDisabled(true)
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
                        "Doe", text: $onboardingViewModel.newUser.lastName
                    )
                    .autocorrectionDisabled(true)
                    .padding()
                    .frame(width:184, height: 50)
                    .background(Color.ui.grayF6F6F6)
                    .cornerRadius(10)
                }
                
            }
            .padding(.vertical, 20)
            
            VStack(alignment: .leading){
                HStack {
                    Text("EMAIL")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.black)
                    
                    if invalidEmail {
                        Text("Please enter a valid email address.")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.red)
                    }
                }
                
                TextField(
                    "example@gmail.com", text: $onboardingViewModel.newUser.email
                )
                .keyboardType(.emailAddress)
                .autocorrectionDisabled(true)
                .focused($emailFieldIsFocused)
                .textInputAutocapitalization(.never)
                .padding()
                .frame(width:378, height: 50)
                .background(Color.ui.grayF6F6F6)
                .cornerRadius(10)
                
            }
            .padding(.bottom, 20)
            
            
            VStack(alignment: .leading){
                HStack {
                    Text("PHONE NUMBER")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.black)
                    
                    if invalidPhone {
                        Text("Please enter 10 digit phone number.")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.red)
                    }
                }
                
                TextField(
                    "(   )  -", text: $onboardingViewModel.newUser.phoneNumber
                )
                .focused($phoneFieldIsFocused)
                .padding()
                .frame(width:378, height: 50)
                .background(Color.ui.grayF6F6F6)
                .cornerRadius(10)
            }
            .padding(.bottom, 20)
            
            Spacer()
            
            Button {
                invalidEmail = false
                invalidPhone = false
                
                // Valid email
                if isValidEmail(onboardingViewModel.newUser.email) && isNumeric && hasTenDigits {
                    navigationModel.path.append(OnboardingDestination.role)
                    return
                }
                
                // Check for invalid inputs
                if !isValidEmail(onboardingViewModel.newUser.email) {
                    invalidEmail = true
                    emailFieldIsFocused = true
                }
                
                if !isNumeric || !hasTenDigits {
                    invalidPhone = true
                    phoneFieldIsFocused = true
                }
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
            await onboardingViewModel.getPlayerStyles()
        }
    }
    
    var isNumeric: Bool {
        return onboardingViewModel.newUser.phoneNumber.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    var hasTenDigits: Bool {
        return onboardingViewModel.newUser.phoneNumber.count == 10
    }
    
    
    private func isDisabled() -> Bool {
        return onboardingViewModel.newUser.firstName.isEmpty || onboardingViewModel.newUser.lastName.isEmpty || onboardingViewModel.newUser.email.isEmpty || onboardingViewModel.newUser.phoneNumber.isEmpty
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct CircularProfileImage: View {    
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
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        switch onboardingViewModel.imageState {
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

struct CreatePlayerProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlayerProfileView()
            .environmentObject(NavigationModel())
            .environmentObject(OnboardingViewModel(ckUserViewModel: CloudKitUserViewModel(userRepository: UserRepository(), navigationModel: NavigationModel()), userRepository: UserRepository(), navigationModel: NavigationModel()))
    }
}
