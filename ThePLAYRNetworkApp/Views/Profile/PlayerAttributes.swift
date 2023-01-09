//
//  PlayerAttributes.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 1/1/23.
//

import SwiftUI

enum Attribute: String, CaseIterable, Identifiable {
    case experience, speed, defense, offense, rebounding
    var id: Self { self }
}

struct PlayerAttributes: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Attributes")
                .font(.system(size: 20, weight: .semibold))
            
            ForEach(Attribute.allCases) { attribute in
                PlayerAttributeCell(attribute: attribute)
            }
        }
    }
}

struct PlayerAttributeCell: View {
    let attribute: Attribute
    
    var body: some View {
        HStack {
            Text(attribute.rawValue.capitalized)
            
            Spacer()
            
            AttributeRatingView()
        }
    }
}

struct AttributeRatingView: View {
    @State var rating: Int = 3
    var maximumRating = 5
    var primaryColor = Color.ui.accent
    var secondaryColor = Color.black
    
    var body: some View {
        HStack {
            ForEach(1..<maximumRating + 1, id: \.self) { i in
                Image(systemName: "circle")
                    .foregroundColor(rating < i ? secondaryColor : primaryColor)
                    .symbolVariant(rating < i ? .none : .fill)
                    .onTapGesture {
                        rating = i
                    }
            }
        }
    }
    
}

struct PlayerAttributes_Previews: PreviewProvider {
    static var previews: some View {
        PlayerAttributes()
    }
}
