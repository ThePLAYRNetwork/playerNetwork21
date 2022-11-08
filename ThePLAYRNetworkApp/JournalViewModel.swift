//
//  JournalViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/7/22.
//

import Foundation

class JournalViewModel: ObservableObject {
    @Published var courtData = Court.sampleCourtData
    @Published var date = Date()
    @Published var selectedDisplay: Int = 0 // 0 is ratio, 1 is percentage
    @Published var selectedNotes: Int = 0
    @Published var selectedDateType: Int = 0
}
