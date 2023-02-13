//
//  EventsItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/13/22.
//

import SwiftUI

struct EventsItem: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Powerlifting w/ Christopher Jones")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Tue July 12 · 10:00am - 11:00 am")
                .font(.system(size: 16))
            
            
            Text("Gym Name")
                .font(.system(size: 16))
            
            
            
            HStack {
                
                Button {
                    //action code
                } label: {
                    Text("Training")
                    
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .frame(width: 75, height: 22)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(5)
                }
                
                Button {
                    //action code
                } label: {
                    Text("Puplic")
                    
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .frame(width: 75, height: 22)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(5)
                }
                
                Spacer()
                
                Button {
                    //action code
                } label: {
                    Text("View")
                        .font(.system(size: 21))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 95, height: 30)
                        .background(Color.ui.accentColor)
                        .cornerRadius(5)
                }
            }
            .padding(.top, -8)
            
        }

        .padding()
        
    }
}

struct EventsItem_Previews: PreviewProvider {
    static var previews: some View {
        EventsItem()
    }
}
