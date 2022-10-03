//
//  PlayersYouMayKnowItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/13/22.
//

import SwiftUI

struct PlayersYouMayKnowItem: View {
    var user: User
    
    var body: some View {
        VStack(spacing: 0) {
            Circle()
                .fill(Color.ui.light_gray)
                .frame(width: 72, height: 72)
                
            Text(user.name)
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .padding(.top, 6)
            
            Spacer()
            
            Button(action: {}) {
                Text("Connect")
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
            }
            .buttonStyle(SmallRedButton())
        }
        .padding(.top, 14)
        .padding(.bottom, 9)
        .frame(width: 120, height: 150)
        .background {
            RoundedRectangle(cornerRadius: 7)
                .fill(.regularMaterial)
        }
        .overlay(alignment: .top) {
            HStack {
                Spacer()
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
            }
            .padding(5)
        }
        
    }
}

struct SmallRedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 14)
            .padding(.vertical, 2)
            .background {
                RoundedRectangle(cornerRadius: 7)
                    .fill(configuration.isPressed ? Color.accentColor.opacity(0.5) : Color.accentColor)
            }
            .foregroundColor(.white)
    }
}

struct PlayersYouMayKnowItem_Previews: PreviewProvider {
    static var previews: some View {
        PlayersYouMayKnowItem(user: User.sampleUsers[0])
            .previewLayout(.sizeThatFits)
    }
}
