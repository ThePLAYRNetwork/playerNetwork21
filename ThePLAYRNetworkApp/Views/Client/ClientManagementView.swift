//
//  ClientManagementView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/28/22.
//

import SwiftUI

struct ClientManagementView: View {
    @State var text: String = ""
    var filters = ["Sort By"]
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                BackButton()
                
                Group {
                    Text("Client Management")
                        .font(.system(size: 24,weight: .bold))
                        .padding(.top, 5)
                        .padding(.bottom, 0)
                    
                    
                    SearchBar(text: $text)
                    
                    
                    LazyHStack(alignment: .top, spacing: 8) {
                        ForEach(filters, id: \.self) { filter in
                            DiscoverFilterItem(filter: filter)
                                .listRowInsets(EdgeInsets())
                        }
                        
                        Button(action: {
                            
                        }) {
                            Text("Active")
                        }
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .buttonStyle(.plain)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 14)
                        .background {
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(.gray, lineWidth: 1)
                        }
                        
                        
                        
                        Button(action: {
                            
                        }) {
                            Text("Unread")
                        }
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .buttonStyle(.plain)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 14)
                        .background {
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(.gray, lineWidth: 1)
                        }
                    }
                    .padding(.trailing)
                    
                    
                    
                    Text("Active Bookings")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top, 15)
                    
                }
                ActiveBookingsRowView()
                
            
                    ForEach(0...3, id: \.self) { letter in
                        PlayerRowView()
                    }
     
                
            }
            .padding()
            
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ClientManagementView_Previews: PreviewProvider {
    static var previews: some View {
        ClientManagementView()
    }
}
