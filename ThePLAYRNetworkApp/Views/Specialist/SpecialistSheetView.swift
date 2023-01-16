//
//  SpecialistSheetView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/29/22.
//

import SwiftUI

struct SpecialistSheetView: View {
    @State private var searchText = ""
    @State var expandList: Bool = true
    @State var yDragTranslation: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                // Content
                SpecialistColumn()
                
                // List Handle
                HStack(alignment: .center) {
                    Rectangle()
                        .frame(width: 40, height: 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10)
                        .opacity(0.25)
                        .padding(.vertical, 8)
                }
                .frame(width: geometry.size.width, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    print("Clicking Handle")
                    expandList.toggle()
                }
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: geometry.size.height) // height of sheet == size of screen
            .background()
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .offset(
                x: 0,
                y: expandList ? 0: -500 + 20    // 20 is height of list handle
            )
            .offset(x: 0, y: self.yDragTranslation)
//            .animation(.spring())
            .animation(.spring(response: 0.55, dampingFraction: 0.825, blendDuration: 0))
            .gesture(
                DragGesture().onChanged { value in
                    self.yDragTranslation = value.translation.height
                }.onEnded { value in
                    // 1. height threshold to be considered "expanded"
                    // 2. If its expanded already and user continues to drag down, keep expandlist as true
                    self.expandList = (value.translation.height > 150 || (value.translation.height >= 0 && expandList))
                    self.yDragTranslation = 0
                }
            )
            .shadow(radius: 1)
        }
        .frame(height: 500)
//        .background(.clear)

    }
}

struct SpecialistSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialistSheetView()
    }
}
