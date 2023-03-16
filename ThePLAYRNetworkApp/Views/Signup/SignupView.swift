////
////  SignupView.swift
////  ThePLAYRNetworkApp
////
////  Created by Timmy Nguyen on 7/27/22.
////
//import SwiftUI
//
//struct SignupView: View {
//    
//    @EnvironmentObject var authViewModel: AuthViewModel
//    
//    var body: some View {
//        VStack {
//            VStack {
//                TextField("Name", text: $authViewModel.name)
//                TextField("Username", text: $authViewModel.username)
//                TextField("Email", text: $authViewModel.email)
//                SecureField("Password", text: $authViewModel.password)
//            }
//            .textFieldStyle(.roundedBorder)
//            .disableAutocorrection(true)
//            
//            Button("Sign up") {
//                authViewModel.signUp()
//            }
//            .buttonStyle(.borderedProminent)
//            .padding()
//            Spacer()
//        }
//        .navigationTitle("Sign up")
//        .padding()
//    }
//}
//
//struct SignupView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            SignupView()
//        }
//        .environmentObject(AuthViewModel())
//    }
//}
