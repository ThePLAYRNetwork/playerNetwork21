//
//  InputDataCell.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/8/22.
//

import SwiftUI

struct InputDataCell: View {
    var section: CourtSection
    @Binding var score: Int
    @Binding var attempt: Int
    var geometry: GeometryProxy
    
    var body: some View {
        HStack(spacing: 0) {
            Text(section.rawValue)
                .frame(width: geometry.size.width * 0.50, alignment: .leading)
            
            Spacer()
            
            TextField("\(score)", value: $score, formatter: NumberFormatter())
                .multilineTextAlignment(.center)
                .frame(width: geometry.size.width * 0.15)

            Spacer()
            
            TextField("\(attempt)", value: $attempt, formatter: NumberFormatter())
                .multilineTextAlignment(.center)
                .frame(width: geometry.size.width * 0.25)
        }
        .padding([.vertical], 10)
        .fontWeight(.medium)
        .foregroundColor(.white)
        .frame(height: 40)
    }
}

struct InputDataCell_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            InputDataCell(section: .rightCorner, score: .constant(5), attempt: .constant(7), geometry: geometry)
//                .border(.orange)
        }
    }
}
