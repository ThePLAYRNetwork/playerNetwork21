//
//  SessionViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 4/3/23.
//

import Foundation


@MainActor
class SessionViewModel: NSObject,ObservableObject {
    @Published var newSession = Session()
    
    
    private let sessionRepository: SessionRepository
    private let navigationModel: NavigationModel
    
    init(sessionRepository: SessionRepository, navigationModel: NavigationModel) {

        self.sessionRepository = sessionRepository
        self.navigationModel = navigationModel
    }
    
    func createSession() async {
        let result = await sessionRepository.createSession(session: newSession)
        switch result {
        case .success(let session):
           self.navigationModel.path.removeLast()
            self.navigationModel.tabSelection = .home    // show home screen
            self.navigationModel.showSessionCreateSuccessAlert = true
            
            
          print("Created sessions successfully")
            self.newSession = Session() // clear inputs
            return
        case .failure(_):
            self.navigationModel.showiCloudErrorAlert = true
         print("failed to create a session")
            return
        }
    }
    
}


