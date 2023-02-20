//
//  AuthViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

// note: guard let vs if let. guard let variable can be used everywhere, if let variable can only be used inside if block
class AuthViewModel: ObservableObject {
//    @Published var currentUser = User()
    @Published var isLoggedIn = Auth.auth().currentUser != nil
    
    @Published var name = ""
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var selection: Tab = .home
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            // if there is a result and no error, continue, else return early
            guard result != nil, error == nil else {
                return
            }
            
            // Success
            self.isLoggedIn = true
        }
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else { return }
            
            // Success
            guard let user = result?.user else { return } // firebaseUser
            
            // Create user object to store into firebase
            let userData = User(id: user.uid, name: self.name, email: self.email, username: self.username.lowercased())
            
            // Add user to firebase
            do {
                let db = Firestore.firestore()
                try db.collection("users")
                    .document(user.uid)
                    .setData(from: userData)
                
                // reset textfields
                self.username = ""
                self.name = ""
                self.email = ""
                self.username = ""
            } catch {
                print("Failed to sign up user: \(self.username)")
            }
            
            self.isLoggedIn = true
        }
    }
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
        } catch {
            print("Error signing out")
        }
    }
}
