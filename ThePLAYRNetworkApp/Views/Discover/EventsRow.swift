//
//  EventsRow.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/13/22.
//

import SwiftUI


struct EventsRow: View {
    @EnvironmentObject var sessionViewModel: SessionViewModel
    
    let sessions = [Session]()
    
    var body: some View {
        
        
         VStack(alignment: .leading, spacing: 10) {
            
             List(sessionViewModel.sessions, id: \.recordID) { session in
                 
                 Text(session.title)
                 
                 
             }
             
             
             
//             List {
//                 ForEach(sessions, id: \.recordID) { session in
//                     EventItem(session: session)
//                     Divider()
//                 }
//                 .onAppear {
//                     Task {
//                       try await sessionViewModel.fetchSession()
//                     }
//                 }
//             }
             
             
//             ForEach(0...3, id: \ .self) { event in
//                        EventsItem()
//                 Divider()
//                    }
         }
         .task {
             do {
                try await sessionViewModel.fetchSession()
             } catch {
                 print(error)
             }
         }
        

        
        }
    
    }
    

struct EventsRow_Previews: PreviewProvider {
    static var previews: some View {
        EventsRow()
    }
}
