//
//  CoverImageRow.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 4/5/23.
//

import SwiftUI
import UIKit

//hstack with 4 squares images
struct CoverImageRow: View {
    @EnvironmentObject var coverImageViewModel: CoverImageViewModel
    
    var body: some View {
   
            VStack(alignment: .leading, spacing: 3) {
                Text("Cover Image".uppercased())
                    .font(.system(size: 12))
                
                
                HStack {
                    
                    RoundedRectangle(cornerRadius: 4)
                        .aspectRatio(1.0, contentMode: .fit) // to keep square shape
                        .overlay {
                            
                            Image("photos")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 34, height: 34)
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    coverImageViewModel.source = .library
                                    coverImageViewModel.showPhotoPicker()
                                }
                            
                            
                            //                        if let image = coverImageViewModel.image {
                            //                            Image(uiImage: image)
                            //                                .resizable()
                            //                                .aspectRatio(contentMode: .fit)
                            //                                .frame(width: 34, height: 34)
                            //                                .foregroundColor(.gray)
                            //                        } else {
                            //                            Image("photos")
                            //                                .resizable()
                            //                                .aspectRatio(contentMode: .fit)
                            //                                .frame(width: 34, height: 34)
                            //                                .foregroundColor(.gray)
                            //                                .onTapGesture {
                            //                                    coverImageViewModel.source = .library
                            //                                    coverImageViewModel.showPhotoPicker()
                            //                                }
                            //                        }
                            
                            
                        }
                        .sheet(isPresented: $coverImageViewModel.showPicker) {
                            ImagePicker(sourceType: coverImageViewModel.source == .library ? .photoLibrary : .camera, selectedImage: $coverImageViewModel.image)
                                .ignoresSafeArea()
                            
                        }
                    
                    
                    RoundedRectangle(cornerRadius: 4)
                        .aspectRatio(1.0, contentMode: .fit) // to keep square shape
                        .overlay {
                            
                            
                            Image(systemName: "camera.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 34, height: 34)
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    coverImageViewModel.source = .camera
                                    coverImageViewModel.showPhotoPicker()
                                }
                            
                            
                            //                        if let image = coverImageViewModel.image {
                            //                            Image(uiImage: image)
                            //                                .resizable()
                            //                                .aspectRatio(contentMode: .fit)
                            //                                .frame(width: 34, height: 34)
                            //                                .foregroundColor(.gray)
                            //                        } else {
                            //                            Image(systemName: "camera.fill")
                            //                                .resizable()
                            //                                .aspectRatio(contentMode: .fit)
                            //                                .frame(width: 34, height: 34)
                            //                                .foregroundColor(.gray)
                            //                                .onTapGesture {
                            //                                    coverImageViewModel.source = .camera
                            //                                    coverImageViewModel.showPhotoPicker()
                            //                                }
                            //                        }
                            //
                            
                        }
                        .sheet(isPresented: $coverImageViewModel.showPicker) {
                            ImagePicker(sourceType: coverImageViewModel.source == .library ? .photoLibrary : .camera, selectedImage: $coverImageViewModel.image)
                                .ignoresSafeArea()
                            
                        }
                    RoundedRectangle(cornerRadius: 4)
                        .aspectRatio(1.0, contentMode: .fit)
                    RoundedRectangle(cornerRadius: 4)
                        .aspectRatio(1.0, contentMode: .fit)
                    
                }
                .foregroundColor(Color.ui.grayECECEC)
                
                
           
                
            }
  
    }
}






struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
