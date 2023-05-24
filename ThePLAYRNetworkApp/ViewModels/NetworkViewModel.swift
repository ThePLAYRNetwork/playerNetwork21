//
//  NetworkViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 5/21/23.
//

import Foundation

@MainActor
class NetworkViewModel: ObservableObject {
    @Published var posts: [Post] = []
    let postRepository = PostRepository()
    
    init() {
        Task {
            await fetchPosts()
        }
    }
    
    func fetchPosts() async {
        let results = await postRepository.fetchPosts()
        switch results {
        case .success(let posts):
            self.posts = posts
            print("Successfully fetched posts: \(posts.count)")
        case .failure(let error):
            print("Error fetching posts: \(error)")
        }
    }
}
