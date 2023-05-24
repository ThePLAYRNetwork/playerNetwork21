//
//  SheetButtonRow.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import SwiftUI

struct SheetButtonRow: View {
    let session: Session
    
    var sessions: [Session]
    
    var body: some View {
        HStack {
            NavigationLink {
                TrainingView(session: session)
            } label: {
                RoundedRectangle(cornerRadius: 4)
                    .shadow(color: Color.ui.grayD9D9D9, radius: 1, x: 0, y: 5)  // drop shadow
                    .aspectRatio(1.0, contentMode: .fit)
                    .overlay {
                        Image("training_icon")
                    }
            }
            .buttonStyle(.plain) // lessens white flash when clicked

            NavigationLink {
                NetworkView()
            } label: {
               RoundedRectangle(cornerRadius: 4)
                    .shadow(color: Color.ui.grayD9D9D9, radius: 1, x: 0, y: 5)  // drop shadow
                    .aspectRatio(1.0, contentMode: .fit)
                    .overlay {
                        Image("network_icon")
                    }
            }
            .buttonStyle(.plain)
            
            NavigationLink {
                DiscoverView()
            } label: {
                RoundedRectangle(cornerRadius: 4)
                    .shadow(color: Color.ui.grayD9D9D9, radius: 1, x: 0, y: 5)  // drop shadow
                    .aspectRatio(1.0, contentMode: .fit)
                    .overlay {
                        Image("discover_icon")
                    }
            }
            .buttonStyle(.plain)

            NavigationLink {
                JournalView()
            } label: {
                RoundedRectangle(cornerRadius: 4)
                    .shadow(color: Color.ui.grayD9D9D9, radius: 1, x: 0, y: 5)  // drop shadow
                    .aspectRatio(1.0, contentMode: .fit)
                    .overlay {
                        Image("journal_icon")
                    }
            }
            .buttonStyle(.plain)
        }
        .foregroundColor(Color.ui.accentColor)
    }
}

//struct SheetButtonRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SheetButtonRow()
//    }
//}
