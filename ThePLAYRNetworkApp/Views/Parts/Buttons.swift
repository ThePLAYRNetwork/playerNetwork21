//
//  Buttons.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 1/8/23.
//

import SwiftUI

struct Buttons: View {
    var body: some View {
        VStack {
            ForEach(ButtonSize.allCases) { buttonSize in
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(ButtonColor.allCases) { buttonColor in
                            Button("Button") {
                                
                            }
                            .buttonStyle(CustomButton(color: buttonColor, size: buttonSize))
                        }
                    }
                }
            }
        }
    }
}

enum ButtonColor: CaseIterable, Identifiable {
    case red, white, black
    var id: Self { self }
}

enum ButtonSize: CaseIterable, Identifiable {
    case small, medium, large
    var id: Self { self }
}

struct CustomButton: ButtonStyle {
    let color: ButtonColor
    let size: ButtonSize
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(handleForegroundColor())
            .padding(.vertical, 7)
            .padding(.horizontal, handleHorizontalPadding())
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(handleBackgroundColor(configuration: configuration))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(handleStrokeColor(configuration: configuration))
                    }
            }
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
    
    func handleHorizontalPadding() -> CGFloat {
        switch size {
        case .small:
            return 15
        case .medium:
            return 25
        case .large:
            return 75
        }
    }
    
    func handleForegroundColor() -> Color {
        switch color {
        case .red:
            return .white
        case .white:
            return Color.ui.green
        case .black:
            return .white
        }
    }
    
    func handleBackgroundColor(configuration: Configuration) -> Color {
        switch color {
        case .red:
            return Color.ui.primary
        case .white:
            return .white
        case .black:
            return Color.ui.green
        }
    }
    
    func handleStrokeColor(configuration: Configuration) -> Color {
        switch color {
        case .red:
            return Color.ui.primary
        case .white:
            return Color.ui.green
        case .black:
            return Color.ui.green
        }
    }
}



struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
