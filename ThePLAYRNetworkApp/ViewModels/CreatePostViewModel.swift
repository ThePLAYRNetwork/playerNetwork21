//
//  CreatePostViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 5/21/23.
//

import Foundation

@MainActor
class CreatePostViewModel: ObservableObject {
    
    @Published var post = Post()
    var postRepository = PostRepository()
    
    func createPost() async {
        let result = await postRepository.createPost(post: post)
        switch result {
        case .success(let post):
            print("Sucessfully created post")
        case .failure(let error):
            print("Error creating post: \(error)")
        }
    }
}
