//
//  ConversationColumnView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/25/22.
//

import SwiftUI

struct ConversationColumnView: View {
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(1...10, id: \.self) {_ in
                    ConversationCell()
                }
            }
        }
    }
}

struct ConversationCell: View {
    var body: some View {
        HStack(alignment: .top, spacing: 9) {
            Circle()
                .fill(Color.ui.grayD9D9D9)
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("User")
                    Spacer()
                    Text(Date.now.formatted(date: .omitted, time: .shortened))
                }
                .foregroundColor(Color.ui.gray959595)
                .font(.system(size: 12))
                
                Text(ConversationCell.sampleText)
                    .font(.system(size: 14))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
    }
}

// test data, remove later
extension ConversationCell {
    static let sampleText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
}

struct ConversationColumnView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationColumnView()
    }
}
