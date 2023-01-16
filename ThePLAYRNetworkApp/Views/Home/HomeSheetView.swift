//
//  HomeSheetView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/29/22.
//

import SwiftUI

struct HomeSheetView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State private var searchText = ""
    @State var expandList: Bool = true
    @State var yDragTranslation: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
//                UpcomingGameRow(categoryName: "Nearby Games", items: homeViewModel.upcomingGames)
                UpcomingGameRow(categoryName: "Nearby Games", items: Game.sampleGames)
                
                SheetButtonRow()
                    .padding()
                
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
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .offset(
                x: 0,
                y: expandList ? -geometry.size.height * 0.30 : -geometry.size.height * 0.70
            )
            .offset(x: 0, y: self.yDragTranslation)
            .animation(.spring())
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
        }
    }
}

struct HomeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSheetView()
            .environmentObject(HomeViewModel())
    }
}
