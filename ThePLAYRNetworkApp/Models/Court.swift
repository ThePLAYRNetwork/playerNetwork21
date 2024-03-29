//
//  Court.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 10/21/22.
//

import Foundation
import SwiftUI


struct Court {
    static var nSections = 14   // belongs to Court type, not any specific instance
    
    var score: [Int]
    var attempts: [Int]
    var selection: Int = -1
    
    init(score: [Int] = Array(repeating: 0, count: nSections), attempts: [Int] = Array(repeating: 0, count: nSections)) {
        self.score = score
        self.attempts = attempts
    }
}

extension Court {
    static private var score = [5, 3, 4, 5, 2, 3, 4, 2, 2, 5, 3, 3, 6, 5]
    static private var attempts = [7, 4, 4, 8, 5, 7, 4, 6, 3, 9, 10, 3, 7, 7]
    static var sampleCourtData = Court(score: score, attempts: attempts)
}
