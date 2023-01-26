//
//  InputDataColumn.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/8/22.
//

import SwiftUI

struct InputDataColumn: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack(spacing: 0) {
                    Spacer()
                    
                    Text("Scored")
                        .frame(width: geometry.size.width * 0.25)

                    
                    Text("Attempts")
                        .frame(width: geometry.size.width * 0.25)
                    
                }
                .foregroundColor(.white)
                .fontWeight(.medium)
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(CourtSection.allCases) { courtSection in
                            InputDataCell(section: courtSection.rawValue, score: "0", attempts: "0", geometry: geometry)
                        }
                    }
                }

            }
            .background(Color.ui.black)
        }
    }
}

struct InputDataColumn_Previews: PreviewProvider {
    static var previews: some View {
        InputDataColumn()
    }
}
