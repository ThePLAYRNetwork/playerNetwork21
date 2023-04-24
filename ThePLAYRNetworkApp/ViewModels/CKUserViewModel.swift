//
//  CKUserViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/13/23.
//

import Foundation
import CloudKit
import SwiftUI
import PhotosUI

@MainActor
class CloudKitUserViewModel: ObservableObject {
    @Published var isSignedInToiCloud: Bool = false
    @Published var user: User = User()
    @Published var showOnboarding = true
    
    private let userRepository: UserRepository
    private let navigationModel: NavigationModel
    
    private lazy var container: CKContainer = CKContainer.default()
    private lazy var database: CKDatabase = container.publicCloudDatabase
    
    init(userRepository: UserRepository, navigationModel: NavigationModel) {
        self.userRepository = userRepository
        self.navigationModel = navigationModel
        
        Task {
            await getiCloudStatus()
            await getUser()
        }
    }
    
    func getUser() async {
        let result = await userRepository.getUser()
        switch result {
        case .success(let user):
            // User has an account
            self.user = user
            self.showOnboarding = false
        case .failure(_):
            // User does not have account an account
            self.showOnboarding = true
        }
    }

    private func getiCloudStatus() async {
        do {
            let status = try await container.accountStatus()
            if status == .available {
                // Note: User is considerd to be logged into iCloud even if they need to enter their passwords but they cannot perform cloudkit oeprations.
                isSignedInToiCloud = true
                print("iCloud is available")
            } else {
                isSignedInToiCloud = false
                self.navigationModel.showiCloudErrorAlert = true
                print("iCloud is unavailable")
            }
        } catch {
            print("Error fetching iCloud status: \(error)")
            isSignedInToiCloud = false
            self.navigationModel.showiCloudErrorAlert = true
        }
    }

}

enum CloudKitError: String, LocalizedError {
    case iCLoudAccountNotFound
    case iCloudAccountNotDetermined
    case iCloudAccountRestricted
    case iCloudAccountUnKown
    case userRecordNotFound
}

