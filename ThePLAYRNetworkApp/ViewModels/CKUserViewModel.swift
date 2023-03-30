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
    @Published var permissionStatus: Bool = false
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var user: User = User()
//    @Published var user: User = User.sampleUsers[0]
    @Published var hasProfile = false
    @Published var playerStyles: [PlayerStyle] = []
    @Published var selectedPlayer = 0
    
    @Published private(set) var imageState: ImageState = .empty

    enum ImageState {
        case empty, loading(Progress), success(Data), failure(Error)
    }
    // set imageSelect to .empty if image is nil, other wise, start loading the image
    @Published var imageSelection: PhotosPickerItem? {
        didSet { // didSet is called whenever the property imageSelection is assigned a new value. (true even if new value is same as old value)
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    @Published var imageData: Data?
    
    private let userRepository: UserRepository
    private let navigationModel: NavigationModel
    
    private lazy var container: CKContainer = CKContainer.default()
    private lazy var database: CKDatabase = container.publicCloudDatabase
    
    init(userRepository: UserRepository, navigationModel: NavigationModel) {
        self.userRepository = userRepository
        self.navigationModel = navigationModel
        
        Task {
            await getiCloudStatus()
            await requestPermission()
            await fetchiCloudUserRecordID()
            
            await getUser()
        }
    }
    
    // Load asset data using transferable
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else { return }
                switch result {
                case .success(let data?):
                    self.imageData = data
                    self.imageState = .success(data)
                case.success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    print("Error loading image: \(error)")
                    self.imageState = .failure(error)
                }
            }
        }
    }
    
    
    func getPlayerStyles() async {
        let result = await userRepository.getPlayerStyles()
        switch result {
        case .success(let playerStyles):
            self.playerStyles = playerStyles
        case .failure(_):
            break
        }
    }
    
    func createUser() async {
        // Profile image
        guard let imageData = self.imageData else { return }
        choosePlayerCard()

        do {
            // get the documents directory url
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            print("documentsDirectory:", documentsDirectory.path)
            // choose a name for your image to save onto phone's directory
            let fileName = "ThePlayrNetwork" + "profileImage.jpg"
            // create the destination file url to save your image
            let url = documentsDirectory.appendingPathComponent(fileName)
            // get your UIImage jpeg data representation and check if the destination file url already exists
            if let image = UIImage(data: imageData) {
                // Always overwrite file, there should only be one file for profile picture
                if let data = image.jpegData(compressionQuality: 1) {
                    try data.write(to: url)
                    user.profileImage = CKAsset(fileURL: url)
                }
                
//                if let data = image.jpegData(compressionQuality:  1), !FileManager.default.fileExists(atPath: url.path) {
//                    // File does not exist, write to file
//                    try data.write(to: url)
//                    user.profileImage = CKAsset(fileURL: url)
//                    print("File does not exist, write to file")
//                    print(url.absoluteString) // example: file:///var/mobile/Containers/Data/Application/22DF1504-D325-4C82-AE4B-84E608767DA7/Documents/ThePlayrNetworkprofileImage.jpg
//                } else {
//                    // File exists, read image data from disk
//                    user.profileImage = CKAsset(fileURL: url)
//                    print("File exists, reading file")
//                    print(url.absoluteString)
//                }
            }
            
        } catch {
            print("error:", error)
        }
        
        let result = await userRepository.createUser(user: user)
        switch result {
        case .success():
            self.hasProfile = true
            self.navigationModel.path.removeLast(navigationModel.path.count)
            self.navigationModel.path.append(ThePlayrNetworkDestination.home)
        case .failure(_):
            // modify ui variables here
            self.hasProfile = false
        }
    }
    
    private func choosePlayerCard() {
        guard playerStyles.count != 0 else { return }
        user.playsLike = playerStyles[selectedPlayer].name
    }
    
    func getUser() async {
        let result = await userRepository.getUser()
        switch result {
        case .success(let user):
            self.user = user
            self.hasProfile = true
        case .failure(_):
            self.hasProfile = false
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
            isSignedInToiCloud = false
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
            isSignedInToiCloud = false
        }
    }
    
    func fetchiCloudUserRecordID() async {
        do {
            let userID = try await container.userRecordID()
            await discoveriCloudUser(id: userID)
        } catch {
            print("Error fetching iCloud record id: \(error)")
            isSignedInToiCloud = false
        }
    }
    
    
    func discoveriCloudUser(id: CKRecord.ID) async {
        do {
            guard let identity = try await container.userIdentity(forUserRecordID: id) else { return }
        } catch {
            print("Error discovering iCloud User: \(error)")
            isSignedInToiCloud = false
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
