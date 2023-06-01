//
//  EventsItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/13/22.
//

import SwiftUI

struct EventsItem: View {
    @EnvironmentObject var sessionViewModel: SessionViewModel
    let session: Session

    var body: some View {
        VStack(alignment: .leading) {
            Text(session.title)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Tue July 12 · 10:00am - 11:00 am")
                .font(.system(size: 16))
            
            Text(session.address)
                .font(.system(size: 16))
            
            
            
            HStack {
                
                Button {
                    //action code
                } label: {
                    Text("Training")
                    
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .frame(width: 66, height: 25)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(5)
                        .offset(y: 4)
                }
                
                Button {
                    //action code
                } label: {
                    Text("Puplic")
                    
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .frame(width: 55, height: 25)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(5)
                        .offset(y: 4)
                }
                
                Spacer()
                
                NavigationLink {
                    SessionView(session: Session.sampleSessions[0])
                } label: {
                    Text("View")
                        .font(.system(size: 21))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 68, height: 33)
                        .background(Color.ui.accentColor)
                        .cornerRadius(10)
                }
            }

        }

        .padding(.horizontal)
        Divider()
        
    }
}

//struct EventsItem_Previews: PreviewProvider {
//    static var previews: some View {
//        EventsItem()
//    }
//}
