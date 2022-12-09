//
//  TrainingConfirmationCell.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 10/10/22.
//

import SwiftUI

struct TrainingConfirmationCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Power Lifting")
            
            VStack(alignment: .listRowSeparatorLeading) {
                HStack {
                    Image("cloud")
                    VStack(alignment: .leading) {
                        Text("Date")
                            .purpleSubHeading()
                        Text("July 11, 2022")
                    }
                }
                
                HStack {
                    Image("clock")
                    VStack(alignment: .leading) {
                        Text("Time")
                            .purpleSubHeading()
                        Text("11:00 am - 12:00 pm")
                    }
                }
                
                HStack {
                    Image("cost")
                    VStack(alignment: .leading) {
                        Text("Cost")
                            .purpleSubHeading()
                        Text("$50")
                    }
                }
            }
            .padding(.leading)
            
            Text("Possibly some short words of policies and cancellation fees by the trainer here. Lorem ipsum dolor sit amet.")
                .font(.system(size: 16))
                .foregroundColor(Color.ui.subheading_text)
                .padding(.horizontal)
        }
        .font(.system(size: 20, weight: .medium))
        .padding(.top)
    }
}

struct TrainingConfirmationCell_Previews: PreviewProvider {
    static var previews: some View {
        TrainingConfirmationCell()
    }
}

struct PurpleSubHeading: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12))
            .foregroundColor(Color.ui.secondary)
    }
}

extension View {
    func purpleSubHeading() -> some View {
        modifier(PurpleSubHeading())
    }
}
