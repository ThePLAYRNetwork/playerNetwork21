//
//  PostRepository.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 5/21/23.
//

import Foundation
import CloudKit

class PostRepository {
    
    private lazy var container: CKContainer = CKContainer.default()
    private lazy var database: CKDatabase = container.publicCloudDatabase
    
    func createReply(reply: Reply) async -> Result<Reply, Error> {
        do {
            var latestCommentRecord = try await fetchComment(commentID: reply.commentID.recordID).get()
            var numberOfReplies = latestCommentRecord[Comment.RecordKey.numberOfReplies] as! Int
            latestCommentRecord[Comment.RecordKey.numberOfReplies] = numberOfReplies + 1

            let replyRecord = await reply.convertToRecord()
            
            let result = try await database.modifyRecords(saving: [replyRecord, latestCommentRecord], deleting: [])

            print("Successfully created reply")
            return .success(reply)
        } catch {
            print("Error creating reply")
            return .failure(error)
        }
    }
    
    func createComment(comment: Comment) async -> Result<Comment, Error> {
        do {
            let currentUser = try await UserRepository().getUser().get()
            var commentToAdd = comment
            commentToAdd.author = currentUser
            
            var latestPostRecord = try await fetchPost(postID: commentToAdd.postID.recordID).get()
            var numberOfComments = latestPostRecord[Post.RecordKey.numberOfComments] as! Int
            latestPostRecord[Post.RecordKey.numberOfComments] = numberOfComments + 1

            let commentRecord = await comment.convertToRecord()
            
            let result = try await database.modifyRecords(saving: [commentRecord, latestPostRecord], deleting: [])

            print("Successfully created comment")
            return .success(commentToAdd)
        } catch {
            print("Error creating comment")
            return .failure(error)
        }
    }
    
    func fetchPosts(cursor: CKQueryOperation.Cursor? = nil) async -> Result<([Post], CKQueryOperation.Cursor?), Error> { // throw -> Post?
        do {
            let predicate = NSPredicate(value: true)
            let query = CKQuery(recordType: "Post", predicate: predicate)
            query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
            do {
                var (postResults, nextCursor): ([(CKRecord.ID, Result<CKRecord, Error>)], CKQueryOperation.Cursor?)
                
                if let cursor = cursor {
                    (postResults, nextCursor) = try await database.records(continuingMatchFrom: cursor, resultsLimit: 3)
                } else {
                    (postResults, nextCursor) = try await database.records(matching: query, resultsLimit: 3)
                }

                var posts: [Post] = try postResults
                    .compactMap { _, result in
                        let record = try result.get()
                        return Post(record: record)
                    }
                
                // Fetch post's author
                for i in posts.indices {
                    if let authorID = posts[i].authorID {
                        posts[i].author = try await fetchUser(userID: authorID)
                    }
                }
                
                // Fetch if current user liked post
                for i in posts.indices {
                    posts[i].isLiked = try await isPostLiked(postID: posts[i].recordID).get() != nil
                    if posts[i].isLiked {
                        print("User liked post: \(posts[i].id)")
                    }
                }
                
                // Even if we finished processing list
                if posts.count == 0 {
                    nextCursor = nil
                }
                return .success((posts, nextCursor))
            } catch {
                print("Failed to get posts: \(error)")
                return .failure(error)
            }
        }
    }
    
    func fetchComments(postID: CKRecord.ID) async -> Result<[Comment], Error> {
        do {
            let predicate = NSPredicate(format: "\(Comment.RecordKey.postID) == %@", postID)
            let query = CKQuery(recordType: "Comment", predicate: predicate)
            query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
            do {
                var (commentResults, _) = try await database.records(matching: query)

                var comments: [Comment] = try commentResults
                    .compactMap { _, result in
                        let record = try result.get()
                        return Comment(record: record)
                    }
                
                // Fetch author info
                for i in comments.indices {
                    if let authorID = comments[i].authorID {
                        comments[i].author = try await fetchUser(userID: authorID)
                    }
                }
                
                // Fetch if current user liked post
                for i in comments.indices {
                    comments[i].isLiked = try await isPostLiked(postID: comments[i].recordID).get() != nil
                    if comments[i].isLiked {
                        print("User liked comment: \(comments[i].id)")
                    }
                }
                
                
                print("Successfully fetched comments: \(comments.count)")
                return .success(comments)
            } catch {
                print("Failed to get comments: \(error)")
                return .failure(error)
            }
        }

    }
    
    func fetchReplies(commentID: CKRecord.ID) async -> Result<[Reply], Error> {
        do {
            let predicate = NSPredicate(format: "\(Reply.RecordKey.commentID) == %@", commentID)
            let query = CKQuery(recordType: "Reply", predicate: predicate)
            query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
            do {
                var (replyResults, _) = try await database.records(matching: query)

                var replies: [Reply] = try replyResults
                    .compactMap { _, result in
                        let record = try result.get()
                        return Reply(record: record)
                    }
                
                // Fetch author info
                for i in replies.indices {
                    if let authorID = replies[i].authorID {
                        replies[i].author = try await fetchUser(userID: authorID)
                    }
                }
                
                // Fetch if current user liked post
                for i in replies.indices {
                    replies[i].isLiked = try await isPostLiked(postID: replies[i].recordID).get() != nil
                    if replies[i].isLiked {
                        print("User liked comment: \(replies[i].id)")
                    }
                }
                
                
                print("Successfully fetched comments: \(replies.count)")
                return .success(replies)
            } catch {
                print("Failed to get comments: \(error)")
                return .failure(error)
            }
        }

    }
    
    func createPost(post: Post) async -> Result<Post, Error> {
        do {
            var postToSave = post
            postToSave.authorID = try await container.userRecordID()
            let record = await postToSave.convertToRecord()
            let userRecord = try await database.save(record)
            print("Post created successfully:\n\(userRecord)")
            return .success(post)
        } catch {
            print("Failed to create game: \(error)")
            return .failure(error)
        }
    }
    
    func fetchUser(userID: CKRecord.ID) async throws -> User {
        do {
            let predicate = NSPredicate(format: "\(User.RecordKey.userID.rawValue) == %@", userID)
            let query = CKQuery(recordType: "User", predicate: predicate)
            
            let (userResults, _) = try await database.records(matching: query, resultsLimit: 1)
            
            if let userResult = userResults.first {
                let record = try userResult.1.get()
                let user = try User(record: record)
                return user
            } else {
                print("Author not found")
                throw CloudKitError.userRecordNotFound
            }
        } catch {
            print("Failed to get author: \(error)")
            throw error
        }
    }
    
    /// Create a like record and update post's like count
    func likePost(post: Post) async -> Result<Post, Error> {
        do {
            let like = Likes(postID: post.recordID)
            let likeRecord = like.convertToRecord()
            
            var latestPostRecord = try await fetchPost(postID: post.recordID).get()
            let numberOfLikes = latestPostRecord[Post.RecordKey.numberOfLikes] as! Int
            latestPostRecord[Post.RecordKey.numberOfLikes] = numberOfLikes + 1

            // creates record if it does not exists
            let result = try await database.modifyRecords(saving: [likeRecord, latestPostRecord], deleting: [])
            
            if let latestPost = Post(record: latestPostRecord) {
                print("Succesfully liked post: \(latestPost.id)")
                return .success(latestPost)
            }
            
            print("Failed to like post")
            return .failure(CloudKitError.userRecordNotFound)
        } catch {
            print("Error liking post: \(error)")
            return .failure(error)
        }
    }
    
    func likeComment(comment: Comment) async -> Result<Comment, Error> {
        do {
            let like = Likes(postID: comment.recordID)
            let likeRecord = like.convertToRecord()
            
            var latestCommentRecord = try await fetchComment(commentID: comment.recordID).get()
            let numberOfLikes = latestCommentRecord[Comment.RecordKey.numberOfLikes] as! Int
            latestCommentRecord[Comment.RecordKey.numberOfLikes] = numberOfLikes + 1

            // creates record if it does not exists
            let result = try await database.modifyRecords(saving: [likeRecord, latestCommentRecord], deleting: [])
            
            if let latestComment = Comment(record: latestCommentRecord) {
                print("Succesfully liked comment: \(comment.id)")
                return .success(latestComment)
            }
            
            print("Failed to like comment")
            return .failure(CloudKitError.userRecordNotFound)
        } catch {
            print("Error liking comment: \(error)")
            return .failure(error)
        }
    }

    func likeReply(reply: Reply) async -> Result<Reply, Error> {
        do {
            let like = Likes(postID: reply.recordID)
            let likeRecord = like.convertToRecord()

            var latestReplyRecord = try await fetchReply(replyID: reply.recordID).get()
            let numberOfLikes = latestReplyRecord[Reply.RecordKey.numberOfLikes] as! Int
            latestReplyRecord[Reply.RecordKey.numberOfLikes] = numberOfLikes + 1

            // creates record if it does not exists
            let result = try await database.modifyRecords(saving: [likeRecord, latestReplyRecord], deleting: [])

            if let latestReply = Reply(record: latestReplyRecord) {
                print("Succesfully liked reply: \(reply.id)")
                return .success(latestReply)
            }

            print("Failed to like reply")
            return .failure(CloudKitError.userRecordNotFound)
        } catch {
            print("Error liking reply: \(error)")
            return .failure(error)
        }
    }
    
    func unlikePost(post: Post) async -> Result<Post, Error> {
        do {
            guard let likeRecordID = try await isPostLiked(postID: post.recordID).get() else { return .failure(CloudKitError.userRecordNotFound) }
            
            let latestPostRecord = try await fetchPost(postID: post.recordID).get()
            let numberOfLikes = latestPostRecord[Post.RecordKey.numberOfLikes] as! Int
            latestPostRecord[Post.RecordKey.numberOfLikes] = numberOfLikes - 1

            let result = try await database.modifyRecords(saving: [latestPostRecord], deleting: [likeRecordID])
            
            if let latestPost = Post(record: latestPostRecord) {
                print("Succesfully unliked post: \(latestPost.id)")
                return .success(latestPost)
            }
            
            print("Failed to unlike post")
            return .failure(CloudKitError.userRecordNotFound)
        } catch {
            print("Error unliking post: \(error)")
            return .failure(error)
        }
    }
    
    func unlikeComment(comment: Comment) async -> Result<Comment, Error> {
        do {
            guard let likeRecordID = try await isPostLiked(postID: comment.recordID).get() else { return .failure(CloudKitError.userRecordNotFound) }
            
            let latestCommentRecord = try await fetchComment(commentID: comment.recordID).get()
            let numberOfLikes = latestCommentRecord[Comment.RecordKey.numberOfLikes] as! Int
            latestCommentRecord[Comment.RecordKey.numberOfLikes] = numberOfLikes - 1

            let result = try await database.modifyRecords(saving: [latestCommentRecord], deleting: [likeRecordID])
            
            if let latestComment = Comment(record: latestCommentRecord) {
                print("Succesfully unliked post: \(latestComment.id)")
                return .success(latestComment)
            }
            
            print("Failed to unlike post")
            return .failure(CloudKitError.userRecordNotFound)
        } catch {
            print("Error unliking post: \(error)")
            return .failure(error)
        }
    }
    
    func unlikeReply(reply: Reply) async -> Result<Reply, Error> {
        do {
            guard let likeRecordID = try await isPostLiked(postID: reply.recordID).get() else { return .failure(CloudKitError.userRecordNotFound) }
            
            let latestReplyRecord = try await fetchComment(commentID: reply.recordID).get()
            let numberOfLikes = latestReplyRecord[Reply.RecordKey.numberOfLikes] as! Int
            latestReplyRecord[Reply.RecordKey.numberOfLikes] = numberOfLikes - 1

            let result = try await database.modifyRecords(saving: [latestReplyRecord], deleting: [likeRecordID])
            
            if let latestReply = Reply(record: latestReplyRecord) {
                print("Succesfully unliked reply: \(latestReply.id)")
                return .success(latestReply)
            }
            
            print("Failed to unlike reply")
            return .failure(CloudKitError.userRecordNotFound)
        } catch {
            print("Error unliking reply: \(error)")
            return .failure(error)
        }
    }
    
    /// Return a Likes record for a post if it exists for the current user
    func isPostLiked(postID: CKRecord.ID) async -> Result<CKRecord.ID?, Error> {
        do {
            let userID = try await container.userRecordID()
            let postRef = CKRecord.Reference(recordID: postID, action: .none)
            let predicate = NSPredicate(format: "creatorUserRecordID == %@ AND \(Likes.RecordKey.postID) == %@", userID, postRef)
            let query = CKQuery(recordType: "Likes", predicate: predicate)
            
            let (likeResult, _) = try await database.records(matching: query, resultsLimit: 1)
            if let likeID = likeResult.first?.0 {
                return .success(likeID)
            }
            
            return .success(nil) // user did not like post
        } catch {
            print("Failed to get like: \(error)")
            return .failure(error)
        }
    }

    func fetchPost(postID: CKRecord.ID) async -> Result<CKRecord, Error> {
        do {
            let predicate = NSPredicate(format: "recordID == %@", postID)
            let query = CKQuery(recordType: "Post", predicate: predicate)
            
            let (postResult, _) = try await database.records(matching: query, resultsLimit: 1)
            if let record = try postResult.first?.1.get() {
                return .success(record)
            }
            return .failure(CloudKitError.userRecordNotFound)
        } catch {
            print("Failed to get like: \(error)")
            return .failure(error)
        }
    }
    
    func fetchComment(commentID: CKRecord.ID) async -> Result<CKRecord, Error> {
        do {
            let predicate = NSPredicate(format: "recordID == %@", commentID)
            let query = CKQuery(recordType: "Comment", predicate: predicate)
            
            let (commentResults, _) = try await database.records(matching: query, resultsLimit: 1)
            if let record = try commentResults.first?.1.get() {
                return .success(record)
            }
            return .failure(CloudKitError.userRecordNotFound)
        } catch {
            print("Failed to get comment: \(error)")
            return .failure(error)
        }
    }
    
    // TODO: might use fetch by id instead of matching because we know recordID
    func fetchReply(replyID: CKRecord.ID) async -> Result<CKRecord, Error> {
        do {
            let predicate = NSPredicate(format: "recordID == %@", replyID)
            let query = CKQuery(recordType: "Reply", predicate: predicate)
            
            let (replyResults, _) = try await database.records(matching: query, resultsLimit: 1)
            if let record = try replyResults.first?.1.get() {
                return .success(record)
            }
            return .failure(CloudKitError.userRecordNotFound)
        } catch {
            print("Failed to get reply: \(error)")
            return .failure(error)
        }
    }
}
