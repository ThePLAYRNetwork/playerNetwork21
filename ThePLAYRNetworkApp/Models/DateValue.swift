//
//  DateValue.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/15/22.
//

import SwiftUI

//Date Value Model...
struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
