//
//  NetworkViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 5/21/23.
//

import Foundation
import CloudKit

@MainActor
class NetworkViewModel: ObservableObject {
    @Published var postViewModels: [PostViewModel] = []
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
            self.postViewModels = posts.map { PostViewModel(post: $0)}
            print("Successfully fetched posts: \(posts.count)")
        case .failure(let error):
            print("Error fetching posts: \(error)")
        }
    }
}
