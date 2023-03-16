//
//  CKUserViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/13/23.
//

import Foundation
import CloudKit

@MainActor
class CloudKitUserViewModel: ObservableObject {
    @Published var permissionStatus: Bool = false
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
//    @Published var userName: String = ""
    @Published var user: User? // user may not exist yet
    
    private let userRepository: UserRepository
    private lazy var container: CKContainer = CKContainer.default()
    private lazy var database: CKDatabase = container.publicCloudDatabase
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        
        Task {
            await getiCloudStatus()
            await requestPermission()
            await fetchiCloudUserRecordID()
            
            await getUser()
        }
    }
    
    func createUser(user: User) async {
        let result = await userRepository.createUser(user: user)
        switch result {
        case .success():
            self.user = user
        case .failure(_):
            // modify ui variables here
            break
        }
    }
    
    func getUser() async {
        let result = await userRepository.getUser()
        switch result {
        case .success(let user):
            self.user = user
        case .failure(_):
            break
        }
    }
    
    private func getiCloudStatus() async {
        do {
            let status = try await container.accountStatus()
            switch status {
            case .available:
                isSignedInToiCloud = true
            case .noAccount:
                error = CloudKitError.iCLoudAccountNotFound.rawValue
            case .couldNotDetermine:
                error = CloudKitError.iCloudAccountNotDetermined.rawValue
            case .restricted:
                error = CloudKitError.iCloudAccountRestricted.rawValue
            default:
                error = CloudKitError.iCloudAccountUnKown.rawValue
            }
        } catch {
            print("Error fetching iCloud status: \(error)")
        }
    }
    
    func requestPermission() async {
        do {
            let status = try await container.requestApplicationPermission([.userDiscoverability])
            if status == .granted {
                permissionStatus = true
            }
        } catch {
            print("Error requesting permission: \(error)")
        }
    }
    
    func fetchiCloudUserRecordID() async {
        do {
            let userID = try await container.userRecordID()
            await discoveriCloudUser(id: userID)
        } catch {
            print("Error fetching iCloud record id: \(error)")
        }
    }
    
    
    func discoveriCloudUser(id: CKRecord.ID) async {
        do {
            guard let identity = try await container.userIdentity(forUserRecordID: id) else { return }
        } catch {
            print("Error discovering iCloud User: \(error)")
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
