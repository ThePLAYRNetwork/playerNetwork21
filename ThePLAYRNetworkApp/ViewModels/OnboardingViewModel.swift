//
//  OnboardingViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/31/23.
//

import Foundation
import CloudKit
import SwiftUI
import PhotosUI


@MainActor
class OnboardingViewModel: ObservableObject {
    
    @Published var newUser: User = User()
    @Published var playerStyles: [PlayerStyle] = []
    @Published var colleges: [College] = []
    @Published var selectedPlayer = 0
    @Published private(set) var imageState: ImageState = .empty

    // set imageSelect to .empty if image is nil, other wise, start loading the image
    @Published var imageSelection: PhotosPickerItem? {
        // didSet is called whenever the property imageSelection is assigned a new value. (true even if new value is same as old value)
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    @Published var imageData: Data?
    
    enum ImageState {
        case empty, loading(Progress), success(Data), failure(Error)
    }
    
    private let ckUserViewModel: CloudKitUserViewModel
    private let userRepository: UserRepository
    private let navigationModel: NavigationModel
    
    init(ckUserViewModel: CloudKitUserViewModel, userRepository: UserRepository, navigationModel: NavigationModel) {
        self.ckUserViewModel = ckUserViewModel
        self.userRepository = userRepository
        self.navigationModel = navigationModel
    }
    
    func createUser() async {
        // Save user's playing style
        newUser.playsLike = getPlayerCard()
        // Save user's pfp image
        if let url = saveImage() {
            newUser.profileImage = CKAsset(fileURL: url)
        }
        
        // Create user record for CloudKit
        let result = await userRepository.createUser(user: newUser)
        switch result {
        case .success(let user):
            self.ckUserViewModel.user = user
            self.ckUserViewModel.showOnboarding = false
            self.navigationModel.path.removeLast(navigationModel.path.count)
            self.navigationModel.path.append(ThePlayrNetworkDestination.home)
        case .failure(_):
            self.navigationModel.showiCloudErrorAlert = true
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
    
    func fetchCollegeData() async {
        guard self.colleges.isEmpty else { return } // move outside
        let urlString = "http://universities.hipolabs.com/search?country=United%20States"
        guard let url = URL(string: urlString) else { return }

        do {
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badRequest }
            let collegeData = try JSONDecoder().decode([College].self, from: data)
            
            // Remove duplicate colleges, API has multible colleges with same name for some reason.
            var seen = Set<String>()
            var temp: [College] = []
            for college in collegeData {
                if !seen.contains(college.name) {
                    temp.append(college)
                    seen.insert(college.name)
                }
            }
            
            self.colleges = temp.sorted { $0.name < $1.name }
            print("Sucessfully fetched college data. Number of colleges: \(self.colleges.count)")
            
        } catch {
            print("Error fetching college data: \(error)")
        }
    }
    
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
    
    private func getPlayerCard() -> String {
        guard playerStyles.count != 0 else { return "" }
        return playerStyles[selectedPlayer].name
    }
    
    private func saveImage() -> URL? {
        do {
            guard let imageData = self.imageData else {
                print("Image not found.")
                return nil
            }
            
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
                    return url
                }
            }
            return nil
        } catch {
            print("error:", error)
            return nil
        }

    }
}

enum FetchError: Error {
    case badRequest
    case badJSON
}
