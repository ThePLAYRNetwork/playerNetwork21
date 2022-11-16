//
//  InputDataCell.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/8/22.
//

import SwiftUI

struct InputDataCell: View {
    @State var section: String
    @State var score: String
    @State var attempts: String
    
    var geometry: GeometryProxy
    
    var body: some View {
        HStack(spacing: 0) {
            Text(section)
                .frame(width: geometry.size.width * 0.5, alignment: .leading)
            
            TextField(
                "\(score)",
                text: $score
            )
            .multilineTextAlignment(.center)
            .frame(width: geometry.size.width * 0.25)

            TextField(
                "\(attempts)",
                text: $attempts
            )
            .multilineTextAlignment(.center)
            .frame(width: geometry.size.width * 0.25)
        }
        .padding([.vertical], 10)
        .padding(.leading)
        .fontWeight(.medium)
        .foregroundColor(.white)
        .background(Color.ui.button_black)
        .frame(height: 40)
    }
}

struct InputDataCell_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            InputDataCell(section: "Right Corner", score: "5", attempts: "7", geometry: geometry)
                .border(.orange)
        }
    }
}
