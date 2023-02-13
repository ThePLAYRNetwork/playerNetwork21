//
//  SelectDayCard.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 12/11/22.
//

import SwiftUI

struct SelectDayCard: View {
    var session: TrainingSession

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(session.day.rawValue.capitalized)
                    .font(.system(size: 14, weight: .medium))
                
                Text("Repeats \(session.repeatOption.rawValue.lowercased())")
                    .font(.system(size: 10))
                    .foregroundColor(Color.ui.gray959595)
                
                Spacer()
                
                Image("cancel_button")
            }
            
            SessionTagView(session: session)
        }
        .padding(.leading, 16)
        .padding(.trailing, 8)
        .padding(.vertical, 7)
        .background(RoundedRectangle(cornerRadius: 7).fill(Color.ui.grayF6F6F6))
    }
}

struct SelectDayCard_Previews: PreviewProvider {
    static var previews: some View {
        SelectDayCard(session: TrainingSessionCollection.sampleSession.data[1])
    }
}

struct SessionTagView: View {
    let session: TrainingSession

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
            ForEach(self.session.times, id: \.id) { tag in
                self.item(for: tag.formattedSessionTime())
                    .padding([.trailing, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag.id == self.session.times.last!.id {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag.id == self.session.times.last!.id {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String) -> some View {
        Text(text)
            .font(.system(size: 12))
            .foregroundColor(Color.ui.blue)
            .padding(.horizontal, 5)
            .padding(.vertical, 2)
            .background(RoundedRectangle(cornerRadius: 5).fill(Color.ui.grayF6F6F6))
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
