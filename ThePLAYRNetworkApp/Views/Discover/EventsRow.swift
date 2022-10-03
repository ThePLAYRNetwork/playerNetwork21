//
//  EventsRow.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/13/22.
//

import SwiftUI


struct EventsRow: View {
    var body: some View {
        
        
         VStack(alignment: .leading, spacing: 10) {
            
        
             ForEach(0...3, id: \ .self) { event in
                        EventsItem()
                 Divider()
                    }
         }
        
        
        }
    
    }
    

struct EventsRow_Previews: PreviewProvider {
    static var previews: some View {
        EventsRow()
    }
}
