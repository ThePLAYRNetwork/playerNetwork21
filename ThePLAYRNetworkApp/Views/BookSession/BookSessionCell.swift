//
//  BookSessionCell.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 1/15/23.
//

import SwiftUI

struct BookSessionCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            BookSessionCellItem(image: Image("cloud"), title: "Date", value: "July 12, 2022")
            
            BookSessionCellItem(image: Image("clock"), title: "Time", value: "11:00 am - 12:00 pm")
            
            BookSessionCellItem(image: Image("cost"), title: "Cost", value: "$50")
            
            Text("Possibly some short words of policies and cancellation fees by the trainer here. Lorem ipsum dolor sit amet. ")
                .foregroundColor(Color.ui.subheading_text)
        }
    }
}

struct BookSessionCellItem: View {
    let image: Image
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 9) {
            image
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(.purple)
                
                Text(value)
                    .font(.system(size: 20))
            }
        }
    }
}

struct BookSessionCell_Previews: PreviewProvider {
    static var previews: some View {
        BookSessionCell()
    }
}
