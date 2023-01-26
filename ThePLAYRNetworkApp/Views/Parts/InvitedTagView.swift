//
//  InvitedTagView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 8/19/22.
//

import SwiftUI

struct InvitedTagView: View {
    @Binding var players: [String]

    @State private var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.players, id: \.self) { tag in
                self.item(for: tag)
                    .padding([.trailing, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.players.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.players.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String) -> some View {
        HStack {
            Text(text)
                .font(.system(size: 16))
            Button(action: { removePlayer(name: text) }) {
                Image(systemName: "multiply")
                    .font(.subheadline)
            }
        }
        .padding([.leading, .trailing], 10)
        .padding([.top, .bottom], 5)
        .font(.body)
        .background(Color.ui.accent)
        .foregroundColor(Color.white)
        .cornerRadius(3)
    }
    
    private func removePlayer(name: String) {
        players = players.filter {$0 != name}
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct InvitedTagView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InvitedTagView(players: .constant(User.sampleUsers.map{ $0.name }))
        }
    }
}
