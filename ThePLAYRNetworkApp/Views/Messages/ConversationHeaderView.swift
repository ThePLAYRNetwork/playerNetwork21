//
//  ConversationHeader.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/25/22.
//

import SwiftUI

struct ConversationHeaderView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showingOptions: Bool

    var body: some View {
        
        VStack {
            Spacer()
            HStack(spacing: 0) {
                Button(action: { dismiss() }) {
                    Image("back_arrow_black")
                        .padding(.trailing, 28)
                }
                .buttonStyle(.plain)
                            
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Jared Mills")
                            .fontWeight(.medium)
                        Circle()
                            .fill(.green.opacity(0.3))
                            .frame(width: 5, height: 5)
                            
                    }
                    Text("Point Guard @school, San Diego")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(Color.ui.subheading_text)
                    
                }
                Spacer()
                
                Button(action: { showingOptions.toggle() }) {
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 18, height: 18)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .frame(height: 75)
        .background(.regularMaterial)
    }
}

struct ConversationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationHeaderView(showingOptions: .constant(false))
    }
}
