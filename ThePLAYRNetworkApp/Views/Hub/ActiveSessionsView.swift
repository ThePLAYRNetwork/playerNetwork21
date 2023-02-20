//
//  ActiveSessionsView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/18/22.
//

import SwiftUI

struct ActiveSessionsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Text("Training Sessions")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .padding(.leading, 17)
                    .padding(.top, 5)
                
                ForEach(0..<2, id: \.self) { session in
                    ActiveSessionItemView()
                  
                }
            
                
                Spacer()
            }
        }
    }
}

struct ActiveSessionsView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveSessionsView()
    }
}
