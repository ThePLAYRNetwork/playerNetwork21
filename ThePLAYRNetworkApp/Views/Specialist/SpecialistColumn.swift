//
//  SpecialistColumn.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 10/4/22.
//

import SwiftUI

struct SpecialistColumn: View {
    let data = Specialist.sampleSpecialists
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 20) {
                ForEach(data) { specialist in
                    SpecialistCell(specialist: specialist)
                }
            }
            .padding()
        }
    }
}

struct SpecialistColumn_Previews: PreviewProvider {
    static var previews: some View {
        SpecialistColumn()
            .border(.blue)
    }
}
