//
//  OnboardingPosition.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 12/20/22.
//

import SwiftUI

struct OnboardingPosition: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ckUserViewModel: CloudKitUserViewModel
    @EnvironmentObject var navigationModel: NavigationModel
//    @Binding var user: User
    
    var body: some View {
        VStack(spacing: 0) {
            CreatePlayerHeader()

            Spacer()
            
            VStack(spacing: 0) {
                PositionRow(selectedPosition: $ckUserViewModel.user.position)
                    .padding([.top, .horizontal])
                
                PlayerCarousel()
                                
                // check out bookmark to fix this using new navigaiton
                Button(action: {
                    Task {
                        await ckUserViewModel.createUser()
                    }
                }) {
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
                .padding(.top, 38)
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

struct PositionRow: View {
    @Binding var selectedPosition: User.Position
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Position".uppercased())
                .font(.system(size: 12, weight: .medium))
            
            HStack{
                ForEach(User.Position.allCases) { position in
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
    @Binding var selectedPosition: User.Position
    let position: User.Position
    
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
            .environmentObject(NavigationModel())
            .environmentObject(CloudKitUserViewModel(userRepository: UserRepository(), navigationModel: NavigationModel()))
    }
}

//// TODO: Maybe store this info as a record
//struct ProPlayer: Identifiable {
//    var id: Int
//    var name: String
//    var image: Image
//}
//
//class Store: ObservableObject {
//    @Published var items: [ProPlayer]
//
//    // dummy data
//    init() {
//        items = []
//        items.append(ProPlayer(id: 0, name: "christ_paul", image: Image("chris")))
//        items.append(ProPlayer(id: 1, name: "kyle_lowry", image: Image("kyle")))
//        items.append(ProPlayer(id: 2, name: "stephen_curry", image: Image("stephen")))
//        items.append(ProPlayer(id: 3, name: "stephen_curry", image: Image("stephen")))
//
//    }
//}


//struct PlayerStyleCarousel: View {
//    @StateObject var store = Store()
//    @State private var snappedItem = 0
//    @State private var draggingItem = 0.0
//
//    var body: some View {
//        VStack(spacing: 0) {
//            Text("Which best describes your playing style?".uppercased())
//                .font(.system(size: 12, weight: .medium))
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.bottom, 10)
//
////            Text("Current index: \(snappedItem)")
////            Text("dragging item: \(draggingItem)")
//
//
//            ZStack {
//                ForEach(store.items) { item in
//
//                    // article view
//                    ZStack {
//                        item.image
//                            .resizable()
//                            .scaledToFit()
//                            .overlay {
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(.white, lineWidth: 2)
//                            }
//                            .shadow(radius: 3)
//
//                    }
//                    .frame(height: 380)
//                    .scaleEffect(1.0 - abs(distance(item.id)) * 0.2 ) // uncomment: v2
//                    .offset(x: myXOffset(item.id), y: 0)
//                    .zIndex(1.0 - abs(distance(item.id)) * 0.1)
//                }
//            }
//            .gesture(
//                DragGesture()
//                    .onChanged { value in
//                        draggingItem = Double(snappedItem) + value.translation.width / 100
//                    }
//                    .onEnded { value in
//                        withAnimation {
//                            draggingItem = Double(snappedItem) + value.translation.width / 100
//                            draggingItem = round(draggingItem).remainder(dividingBy: Double(store.items.count))
//                            snappedItem = Int(draggingItem)
//                        }
//                    }
//            )
//            .padding(.top, 12)
//        }
//
//    }
//
//    func distance(_ item: Int) -> Double {
//        return (draggingItem - Double(item)).remainder(dividingBy: Double(store.items.count))
//    }
//
//    func myXOffset(_ item: Int) -> Double {
//        let angle = Double.pi * 2 / Double(store.items.count) * distance(item)
//        return sin(angle) * 250 // 300
//        //        return sin(angle) * 350 // v2
//
//    }
//
//}
