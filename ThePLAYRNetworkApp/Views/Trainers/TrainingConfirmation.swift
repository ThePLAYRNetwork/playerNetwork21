//
//  TrainingConfirmation.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 10/10/22.
//

import SwiftUI

struct TrainingConfirmation: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Session Information")
                .font(.system(size: 20, weight: .semibold))
            
            ScrollView(.vertical) {
                ForEach(1...2, id: \.self) {_ in
                    TrainingConfirmationCell()
                }
            }
        }
    }
}

struct TrainingConfirmation_Previews: PreviewProvider {
    static var previews: some View {
        TrainingConfirmation()
    }
}
