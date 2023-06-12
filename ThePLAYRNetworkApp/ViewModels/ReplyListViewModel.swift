//
//  ReplyListViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 6/7/23.
//

import Foundation
import CloudKit

@MainActor
class ReplyListViewModel: ObservableObject, Identifiable {
    @Published var replies: [ReplyViewModel] = []
    @Published var reply: Reply = Reply()
    @Published var isLoading = false
    
    let postRepository = PostRepository()
    var commentID: CKRecord.ID
    
    init(commentID: CKRecord.ID) {
        self.commentID = commentID
        Task {
            isLoading = true
            await fetchReplies()
            isLoading = false
        }
    }
    
    func fetchReplies() async {
        let result = await postRepository.fetchReplies(commentID: commentID)
        switch result {
        case .success(let comments):
            self.replies = comments.map { ReplyViewModel(reply: $0) }
        case .failure(let error):
            break
        }
    }
    
    func createReply() async {
        reply.commentID = CKRecord.Reference(recordID: commentID, action: .none)
        let result = await postRepository.createReply(reply: reply)
        switch result {
        case .success(let _):
            break
        case .failure(let error):
            break
        }
    }
    
}
