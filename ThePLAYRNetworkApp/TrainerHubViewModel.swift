//
//  TrainerHubViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/8/22.
//

import Foundation


class TrainerHubViewModel: ObservableObject {
    @Published var date = Date()
    @Published var selectedDateType: Int = 0
}
