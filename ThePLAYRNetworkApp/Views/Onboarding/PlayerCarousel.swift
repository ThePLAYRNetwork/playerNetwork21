//
//  PlayerCarousel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/16/23.
//

import SwiftUI
import CloudKit

struct PlayerCarousel: View {
    @EnvironmentObject var ckUserViewModel: CloudKitUserViewModel
    
    var items: [AnyView] {
        return ckUserViewModel.playerStyles.map { AnyView(PlayerCard(url: $0.playerImage.fileURL)) }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Note: App craches if TabView is empty
            Text("Who best describes your playing style?".uppercased())
                .font(.system(size: 12, weight: .medium))
                .padding(.top, 20)
                .padding(.horizontal)
            
            TeasingTabView(selectedTab: $ckUserViewModel.selectedPlayer, spacing: 15) {
                items
            }
        }
    }
}

struct PlayerCard: View {
    let url: URL?
    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 320, maxHeight: 400)
            } else if phase.error != nil {
                Color.red
            } else {
                ProgressView()
            }
        }
    }
}

struct PlayerCarousel_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCarousel()
            .environmentObject(CloudKitUserViewModel(userRepository: UserRepository(), navigationModel: NavigationModel()))
    }
}


struct TeasingTabView: View {
    
    @Binding var selectedTab: Int
    let spacing: CGFloat
    let views: () -> [AnyView]
    
    @State private var offset = CGFloat.zero
    var viewCount: Int { views().count }
    
    var body: some View {
        
        VStack(spacing: spacing) {
            GeometryReader { geo in
                let width = geo.size.width * 0.7
                
                LazyHStack(spacing: spacing) {
                    Color.clear
                        .frame(width: geo.size.width * 0.15 - spacing)
                    ForEach(0..<viewCount, id: \.self) { idx in
                        views()[idx]
                            .frame(width: width)
                        //                            .border(.orange)
                    }
                }
                .offset(x: CGFloat(-selectedTab) * (width + spacing) + offset)
                .animation(.easeOut, value: selectedTab)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = value.translation.width
                        }
                        .onEnded { value in
                            withAnimation(.easeOut) {
                                offset = value.predictedEndTranslation.width
                                selectedTab -= Int((offset / width).rounded())
                                selectedTab = max(0, min(selectedTab, viewCount-1))
                                offset = 0
                            }
                        }
                )
            }
            .frame(height: 400)
            //            .border(.purple)
            
            //            .frame(height: 320)
            
            //            HStack {
            //                ForEach(0..<viewCount, id: \.self) { idx in
            //                    Circle().frame(width: 8)
            //                        .foregroundColor(idx == selectedTab ? .primary : .secondary.opacity(0.5))
            //                        .onTapGesture {
            //                            selectedTab = idx
            //                        }
            //                }
            //            }
            //            .padding(.bottom)
        }
        //        .border(.blue)
        
    }
}
