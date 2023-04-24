//
//  LocationSearchService.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 4/6/23.
//

import Foundation
import SwiftUI
import MapKit
import Combine

class LocationSearchService: NSObject, MKLocalSearchCompleterDelegate {
    @Published var searchQuery = ""
    @Published var completions: [MKLocalSearchCompletion] = []
    @Published var selectedCompletion: MKLocalSearchCompletion?
    var completer: MKLocalSearchCompleter
    var cancellable: AnyCancellable?
    
    override init() {
        completer = MKLocalSearchCompleter()
        completer.resultTypes = .pointOfInterest
        super.init()
        cancellable = $searchQuery.assign(to: \.queryFragment, on: self.completer)
        completer.delegate = self
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.completions = completer.results
    }
    
}

extension MKLocalSearchCompletion: Identifiable {}
