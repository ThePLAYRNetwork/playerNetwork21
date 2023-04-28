//
//  Test.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 4/6/23.
//

import SwiftUI
import MapKit

struct LocationSearchBar: View {
    
    enum Field: Hashable {
        case title, location, details
    }

    
    @EnvironmentObject var createViewModel : CreateGameViewModel
    @State var isShowingResults = false
    @FocusState var focusedField: CreateGameView.Field?
    var field: CreateGameView.Field

    
    @Binding var isInvalid: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text("Location".uppercased())
                
                if isInvalid {
                    Text("Invalid Input".uppercased())
                        .foregroundColor(.red)
                        .lineLimit(1)
                }
            }
            .font(.system(size: 12, weight: .medium))

            SearchBarAddress(text: $createViewModel.locationSearchService.searchQuery)
                .focused($focusedField, equals: .location)
                .onTapGesture {
                    createViewModel.locationSearchService.searchQuery = ""
                    isShowingResults = true
                }
                .padding(.horizontal, -8) // only way to remove padding from search bar
                .padding(.vertical, -10)
                .overlay {
                    if isShowingResults
                        && createViewModel.locationSearchService.completions.count > 0
                        && focusedField == .location {
                        List(createViewModel.locationSearchService.completions) { completion in
                            if completion.subtitle != "" {
                                VStack(alignment: .leading) {
                                    Text(completion.title)
                                    Text(completion.subtitle)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .onTapGesture {
                                    
                                    // update search text
                                    createViewModel.locationSearchService.searchQuery = completion.title
                                    // update game locations
                                    createViewModel.locationSearchService.selectedCompletion = completion
//                                    createViewModel.newGame.place = completion.title
//                                    createViewModel.newGame.address = completion.subtitle
                                    isShowingResults = false
                                    focusedField = nil
                                }
                                
                            }
                        }
                        .listStyle(.plain)
                        .frame(height: 200)
                        .offset(x: 0, y: 125)
                        .shadow(radius: 2)
                    }
                }
                        
        }
    }
}

struct LocationSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchBar(field: .location, isInvalid: .constant(false))
            .environmentObject(CreateGameViewModel(gameRepository: GameRepository(), navigationModel: NavigationModel()))
        //            .border(.blue)
        
    }
}
