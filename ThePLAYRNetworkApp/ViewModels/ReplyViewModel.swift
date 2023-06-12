//
//  ReplyViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 6/7/23.
//

import Foundation

@MainActor
class ReplyViewModel: ObservableObject, Identifiable {
    @Published var reply: Reply
    
    let postRepository = PostRepository()

    init(reply: Reply) {
        self.reply = reply
    }
        
    func onTappedLikeButton() async {
        if reply.isLiked {
            await unlikeComment()
        } else {
            await likeComment()
        }
    }
    
    func likeComment() async {
        let prevLikes = reply.numberOfLikes
        reply.numberOfLikes += 1
        reply.isLiked = true
        let results = await postRepository.likeReply(reply: reply)
        switch results {
        case .success(let _):
            reply.isLiked = true
        case .failure(let error):
            reply.numberOfLikes = prevLikes
            reply.isLiked = false
        }
    }
    
    func unlikeComment() async {
        let prevLikes = reply.numberOfLikes
        reply.numberOfLikes -= 1
        reply.isLiked = false
        let results = await postRepository.unlikeReply(reply: reply)
        switch results {
        case .success(let _):
            reply.isLiked = false
        case .failure(let error):
            reply.numberOfLikes = prevLikes
            reply.isLiked = true
        }
    }
}
