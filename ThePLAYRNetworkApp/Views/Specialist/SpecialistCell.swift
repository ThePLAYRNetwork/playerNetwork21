//
//  SpecialistCell.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 10/4/22.
//

import SwiftUI

struct SpecialistCell: View {
    let specialist: Specialist
    
    var body: some View {
        VStack(spacing: 0) {
            // top red section
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(specialist.title)
                    Spacer()
                    Text("$\(specialist.price)")
                }
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 4)
                
                HStack {
                    Text(specialist.date.formatted(date: .long, time: .omitted))
                    Ellipse()
                        .frame(width: 4, height: 4)
                    Text(specialist.date.formatted(date: .omitted, time: .shortened))
                }
                Text("Gym Name, \(specialist.location)")
                Spacer()
            }
            .frame(height: 100)
            .padding()
            .foregroundColor(.white)
            .background(Color.ui.primary)
            
            // white section
            HStack {
                Text("with \(specialist.trainer)")
                Spacer()
                Button("Join", action: {})
            }
            .fontWeight(.medium)
            .padding()
            .background()   // automatically makes it white?
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 4, x: 0, y: 4)
    }
}

struct SpecialistCell_Previews: PreviewProvider {
    static var previews: some View {
        SpecialistCell(specialist: Specialist.sampleSpecialists[0])
    }
}
