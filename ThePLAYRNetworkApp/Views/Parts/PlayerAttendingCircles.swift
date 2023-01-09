//
//  PlayerAttendingCircles.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/29/22.
//

import SwiftUI

struct PlayerAttendingCircles: View {
    var body: some View {
        HStack(spacing: -4) {
            ForEach(0..<3) { i in
                if i < 2 {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.ui.placeholders)
                        .overlay {
                            Circle().stroke(.white)
                        }
                }
                else {
                    HStack(spacing: -5) {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.ui.placeholders)
                            .overlay {
                                Circle().stroke(.white)
                            }
                        Text("12")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .background(
                                Circle()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.ui.buttons)
                            )
                            .fixedSize() // add this to show in detail view for some reason?
                    }
                    .padding(.trailing, 7) // fix offset, negative padding doesn't adjust frame
                }
            }
        }
    }
}

struct PlayerAttendingCirclesSmall: View {
    var body: some View {
        HStack(spacing: -4) {
            ForEach(0..<3) { i in
                if i < 2 {
                    Circle()
                        .frame(width: 33, height: 33)
                        .foregroundColor(Color.ui.placeholders)
                        .overlay {
                            Circle().stroke(.white)
                        }
                }
                else {
                    HStack(spacing: -5) {
                        Circle()
                            .frame(width: 33, height: 33)
                            .foregroundColor(Color.ui.placeholders)
                            .overlay {
                                Circle().stroke(.white)
                            }
                        Text("12")
                            .font(.system(size: 8))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .background(
                                Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.ui.buttons)
                            )
                            .fixedSize() // add this to show in detail view for some reason?
                    }
                    .padding(.trailing, 7) // fix offset, negative padding doesn't adjust frame
                }
            }
        }
    }
}

struct PlayerAttendingCircles_Previews: PreviewProvider {
    static var previews: some View {
        PlayerAttendingCircles()
        PlayerAttendingCirclesSmall()
    }
}
