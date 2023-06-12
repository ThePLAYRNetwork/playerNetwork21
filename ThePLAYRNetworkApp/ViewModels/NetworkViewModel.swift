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
    @Published var cursor: CKQueryOperation.Cursor? = nil
    let postRepository = PostRepository()
    
    init() {
        Task {
            
            postViewModels.append(contentsOf: await fetchPosts())
        }
    }
    
    func fetchCurrentUser() async {
    }
    
    func fetchPosts(cursor: CKQueryOperation.Cursor? = nil) async -> [PostViewModel] {
        let results = await postRepository.fetchPosts(cursor: cursor)
        switch results {
        case .success(let postsResult):
            let newPosts = postsResult.0.map { PostViewModel(post: $0)}
            self.cursor = postsResult.1 // side effect (something that occurs that is not related to return)
            return newPosts
        case .failure(let error):
            print("Error fetching posts: \(error)")
            return []
        }
    }
}
