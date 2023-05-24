//
//  EventsRow.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/13/22.
//

import SwiftUI


struct EventsRow: View {
    @EnvironmentObject var sessionViewModel: SessionViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            ForEach(sessionViewModel.sessions) { session in
                EventItem(session: session)
            }
        }
    }
    
}


struct EventsRow_Previews: PreviewProvider {
    static var previews: some View {
        EventsRow()
    }
}
