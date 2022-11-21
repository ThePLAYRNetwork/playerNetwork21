//
//  DefenseTrainingRowView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/15/22.
//

import SwiftUI

struct DefenseTrainingRowView: View {
    var body: some View {
        VStack {
            ForEach(0..<2, id: \.self) { item in
                DefenseTrainingItemView()
                    .padding(.horizontal)
            }
        }
    }
}

struct DefenseTrainingRowView_Previews: PreviewProvider {
    static var previews: some View {
        DefenseTrainingRowView()
    }
}
