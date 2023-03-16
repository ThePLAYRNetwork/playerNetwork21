//
//  UserApiService.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/13/23.
//

import Foundation
import CloudKit

protocol UserApiService {
    func createUser(user: User) async -> Result<Void, Error>
    
    func getUser() async throws -> Result<User, Error>
    
}
