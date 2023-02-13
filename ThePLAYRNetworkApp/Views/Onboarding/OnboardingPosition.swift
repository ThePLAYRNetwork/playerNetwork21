//
//  OnboardingPosition.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 12/20/22.
//

import SwiftUI

// Color.ui.background_gray
// RoundedShape not found
struct OnboardingPosition: View {
    @State var selectedPosition: Position = .guard
    @State var currentIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            createPlayerHeader()
            
            Spacer()
            
            VStack(spacing: 0) {
                PositionRow(selectedPosition: $selectedPosition)
                
                PlayerStyleCarousel()
                    .padding(.top, 30)
                
                Spacer()
                
                Button(action: {}) {
                    Text("Finish")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 80)
                        .background {
                            RoundedRectangle(cornerRadius: 34)
                                .fill(Color.ui.accentColor)
                        }
                }
                .buttonStyle(.plain)
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

enum Position: String, CaseIterable, Identifiable {
    case `guard`, wing, forward
    var id: Self { self }
}

struct PositionRow: View {
    @Binding var selectedPosition: Position
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Position".uppercased())
                .font(.system(size: 12, weight: .medium))
            
            HStack{
                ForEach(Position.allCases) { position in
                    PositionCell(
                        selectedPosition: $selectedPosition,
                        position: position
                    )
                }
                
            }
            
        }
    }
}

struct PositionCell: View {
    @Binding var selectedPosition: Position
    let position: Position
    
    var body: some View {
        Button(action: { selectedPosition = position }) {
            RoundedRectangle(cornerRadius: 5)
                .stroke(selectedPositionColor())
                .aspectRatio(1.0, contentMode: .fit)
                .overlay {
                    VStack(spacing: 0) {
                        Image(position.rawValue)
                            .resizable()
                            .scaledToFit()
                        
                        Spacer()
                        
                        Text(position.rawValue.capitalized)
                            .font(.system(size: 14))
                            .foregroundColor(selectedPositionColor())
                    }
                    .padding(5)
                }
        }
        .buttonStyle(.plain)
        .background {
            position == selectedPosition ? .clear : Color.ui.grayC6C6C6
        }
    }
    
    func selectedPositionColor() -> Color {
        return position == selectedPosition ? Color.ui.accentColor : Color.ui.gray959595
    }
}

struct OnboardingPosition_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPosition()
    }
}

struct ProPlayer: Identifiable {
    var id: Int
    var image: Image
}

class Store: ObservableObject {
    @Published var items: [ProPlayer]
    
    // dummy data
    init() {
        items = []
        items.append(ProPlayer(id: 0, image: Image("chris")))
        items.append(ProPlayer(id: 1, image: Image("kyle")))
        items.append(ProPlayer(id: 2, image: Image("stephen")))
        items.append(ProPlayer(id: 3, image: Image("stephen")))
        items.append(ProPlayer(id: 4, image: Image("stephen")))
        items.append(ProPlayer(id: 5, image: Image("stephen")))
        
        
    }
}


struct PlayerStyleCarousel: View {
    
    @StateObject var store = Store()
    @State private var snappedItem = 0
    @State private var draggingItem = 0.0
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Which best describes your playing style?".uppercased())
                .font(.system(size: 12, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            //            Text("Current index: \(snappedItem)")
            
            ZStack {
                ForEach(store.items) { item in
                    
                    // article view
                    ZStack {
                        item.image
                            .resizable()
                            .scaledToFit()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white, lineWidth: 2)
                            }
                            .shadow(radius: 3)
                        
                    }
                    .frame(height: 380)
                    .scaleEffect(1.0 - abs(distance(item.id)) * 0.2 ) // uncomment: v2
                    .offset(x: myXOffset(item.id), y: 0)
                    .zIndex(1.0 - abs(distance(item.id)) * 0.1)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        draggingItem = Double(snappedItem) + value.translation.width / 100
                    }
                    .onEnded { value in
                        withAnimation {
                            draggingItem = Double(snappedItem) + value.translation.width / 100
                            draggingItem = round(draggingItem).remainder(dividingBy: Double(store.items.count))
                            snappedItem = Int(draggingItem)
                        }
                    }
            )
            .padding(.top, 12)
        }
        
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(store.items.count))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(store.items.count) * distance(item)
        return sin(angle) * 250 // 300
        //        return sin(angle) * 350 // v2
        
    }
    
}
