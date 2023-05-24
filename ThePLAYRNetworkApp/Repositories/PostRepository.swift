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
    
    func fetchPosts() async -> Result<[Post], Error> { // throw -> Post?
        do {
            let predicate = NSPredicate(value: true)
            let query = CKQuery(recordType: "Post", predicate: predicate)
            // TODO: make creationDate sortable on CloudKit
//            query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            
            do {
                var (postResults, _) = try await database.records(matching: query)

                var posts: [Post] = try postResults
                    .compactMap { _, result in
                        let record = try result.get()
                        return Post(record: record)
                    }
                
                for i in posts.indices {
                    if let authorID = posts[i].authorID {
                        posts[i].author = try await fetchAuthor(authorID: authorID)
                    }
                }
                
                return .success(posts)
            } catch {
                print("Failed to get posts: \(error)")
                return .failure(error)
            }
        }
    }
    
    func createPost(post: Post) async -> Result<Post, Error> {
        do {
            let record = try await post.convertToRecord()
            let userRecord = try await database.save(record)
            print("Game created successfully:\n\(userRecord)")
            return .success(post)
        } catch {
            print("Failed to create game: \(error)")
            return .failure(error)
        }
    }
    
    func fetchAuthor(authorID: CKRecord.Reference) async throws -> User {
        do {
            var container: CKContainer = CKContainer.default()
            var database: CKDatabase = container.publicCloudDatabase
            let predicate = NSPredicate(format: "\(User.RecordKey.userID.rawValue) == %@", authorID)
            let query = CKQuery(recordType: "User", predicate: predicate)
            
            let (userResults, _) = try await database.records(matching: query, resultsLimit: 1)
            
            if let userResult = userResults.first {
                let record = try userResult.1.get()
                let user = try User(record: record)
                print("Succesfully fetched author")
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
}
