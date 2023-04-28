//
//  SessionLocationSearchBar.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 4/26/23.
//

import SwiftUI

struct SessionLocationSearchBar: View {
    
    enum SessionField: Hashable {
        case title, location, details
    }
    
    @EnvironmentObject var createSessionViewModel: SessionViewModel
    @State var isShowingResults = false
    @FocusState var sessionFocusedField: CreateSessionView.SessionField?
    var sessionField: CreateSessionView.SessionField
    
 
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
                    
                    SearchBarAddress(text: $createSessionViewModel.locationSearchService.searchQuery)
                        .focused($sessionFocusedField, equals: .location)
                        .onTapGesture {
                            createSessionViewModel.locationSearchService.searchQuery = ""
                            isShowingResults = true
                        }
                        .padding(.horizontal, -8) // only way to remove padding from search bar
                        .padding(.vertical, -10)
                        .overlay {
                            if isShowingResults
                                &&
                                createSessionViewModel.locationSearchService.completions.count > 0
                                &&
                                sessionFocusedField == .location {
                                List(createSessionViewModel.locationSearchService.completions) { completion in
                                    if completion.subtitle != "" {
                                        VStack(alignment: .leading) {
                                            Text(completion.title)
                                            Text(completion.subtitle)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        .onTapGesture {
                                            
                                            // update search text
                                            createSessionViewModel.locationSearchService.searchQuery = completion.title
                                            // update session locations
                                            createSessionViewModel.locationSearchService.selectedCompletion = completion
                                            //                                    createViewModel.newGame.place = completion.title
                                            //                                    createViewModel.newGame.address = completion.subtitle
                                            isShowingResults = false
                                            sessionFocusedField = nil
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

//struct SessionLocationSearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionLocationSearchBar()
//    }
//}
