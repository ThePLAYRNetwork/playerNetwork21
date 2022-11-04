//
//  EventItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 10/12/22.
//

import SwiftUI

struct EventItem: View {
    var body: some View {
        HStack{
            
            VStack(spacing:5){
                Text("20")
                    .fontWeight(.bold)
                Text("WED")
                    .font(.caption)
            }
            
            VStack {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(Color("orange"))
                        .frame(maxWidth: .infinity, maxHeight: 70)
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading) {
                        Text("5:30 pm - 8:00 pm")
                            .font(.caption)
                        Text("Open Gym")
                            .font(.body)
                        Text("Main Gym")
                            .font(.caption2)
                    }
                    .padding()
                    
                }
                
            }
        }

    }
}

struct EventItem_Previews: PreviewProvider {
    static var previews: some View {
        EventItem()
    }
}
