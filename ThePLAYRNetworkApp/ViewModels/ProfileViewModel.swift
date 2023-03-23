//
//  ProfileViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 3/17/23.
//

import Foundation
import SwiftUI
import _PhotosUI_SwiftUI


class ProfileViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
     
    
    init() {
 
    }

    enum Picker {
        enum Source: String {
            case library, camera
        }
        
        static func checkPermissions() -> Bool {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                return true
            } else {
                return false
            }
        }
    }
    


    
    func showPhotoPicker() {

            if source == .camera {
                if !Picker.checkPermissions() {
                    print("There is no camera on this device")
                    return
                }
            }
            showPicker = true
            
    }
    
}
