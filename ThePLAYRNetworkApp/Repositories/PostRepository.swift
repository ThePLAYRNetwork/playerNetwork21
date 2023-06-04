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
    
    func createComment(comment: Comment) async -> Result<Comment, Error> {
        do {
            var latestPostRecord = try await fetchPost(postID: comment.postID.recordID).get()
            var numberOfComments = latestPostRecord[Post.RecordKey.numberOfComments] as! Int
            latestPostRecord[Post.RecordKey.numberOfComments] = numberOfComments + 1

            let commentRecord = await comment.convertToRecord()
            
            let result = try await database.modifyRecords(saving: [commentRecord, latestPostRecord], deleting: [])

            print("Successfully created comment")
            return .success(comment)
        } catch {
            print("Error creating comment")
            return .failure(error)
        }
    }
    
    func fetchPosts() async -> Result<[Post], Error> { // throw -> Post?
        do {
            let predicate = NSPredicate(value: true)
            let query = CKQuery(recordType: "Post", predicate: predicate)
            // TODO: make creationDate sortable on CloudKit
            query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
            do {
                var (postResults, _) = try await database.records(matching: query)

                var posts: [Post] = try postResults
                    .compactMap { _, result in
                        let record = try result.get()
                        return Post(record: record)
                    }
                
                // Fetch post's author
                for i in posts.indices {
                    if let authorID = posts[i].authorID {
                        posts[i].author = try await fetchAuthor(authorID: authorID)
                    }
                }
                
                // Fetch if current user liked post
                for i in posts.indices {
                    posts[i].isLiked = try await isPostLiked(postID: posts[i].recordID).get() != nil
                    if posts[i].isLiked {
                        print("User liked post: \(posts[i].id)")
                    }
                }
                                
                return .success(posts)
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
                        comments[i].author = try await fetchAuthor(authorID: authorID)
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
    
    func fetchAuthor(authorID: CKRecord.ID) async throws -> User {
        do {
            let predicate = NSPredicate(format: "\(User.RecordKey.userID.rawValue) == %@", authorID)
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
            let numberOfLikes = latestPostRecord[.likes] as! Int
            latestPostRecord[.likes] = numberOfLikes + 1

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
    
    func unlikePost(post: Post) async -> Result<Post, Error> {
        do {
            guard let likeRecordID = try await isPostLiked(postID: post.recordID).get() else { return .failure(CloudKitError.userRecordNotFound) }
            
            let latestPostRecord = try await fetchPost(postID: post.recordID).get()
            let numberOfLikes = latestPostRecord[.likes] as! Int
            latestPostRecord[.likes] = numberOfLikes - 1

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
}
