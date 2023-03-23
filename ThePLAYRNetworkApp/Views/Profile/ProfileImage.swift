//
//  ProfileImage.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 3/17/23.
//

import SwiftUI
import _PhotosUI_SwiftUI


    
    struct ProfileImage: View {
    @StateObject var vm: ProfileViewModel
     @Binding var user: User

        
        var body: some View {
            
            VStack(alignment: .center) {
                
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .background {
                            Circle().fill (
                                Color.ui.grayF6F6F6
                            )
                        }
                    
                        .overlay(alignment: .bottomTrailing) {
                            
                            Image(systemName: "camera.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size:30))
                                .foregroundColor(.accentColor)
                            
                        }
                } else {
                    Image(systemName: "photo.fill")
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .background {
                            Circle().fill (
                                Color.ui.grayF6F6F6
                            )
                        }
                        .onTapGesture {
                            vm.source = .library
                            vm.showPhotoPicker()
                        }
                    
                        .overlay(alignment: .bottomTrailing) {
                            
                            Button{
                                vm.source = .camera
                                vm.showPhotoPicker()
                            } label: {
                                Image(systemName: "camera.circle.fill")
                                    .symbolRenderingMode(.multicolor)
                                    .font(.system(size:30))
                                    .foregroundColor(.accentColor)
                                
                            }
                            
                            
                        }
                }
                
     
            Spacer()
    
        .sheet(isPresented: $vm.showPicker) {
            ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                .ignoresSafeArea()
        }
                
                
            }
            
            
            
            
        }
    }
    
//    struct ProfileImage_Previews: PreviewProvider {
//        static var previews: some View {
//            ProfileImage()
//        }
//    }
