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
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
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
                        await onboardingViewModel.createUser()
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
            .environmentObject(OnboardingViewModel(ckUserViewModel: CloudKitUserViewModel(userRepository: UserRepository(), navigationModel: NavigationModel()), userRepository: UserRepository(), navigationModel: NavigationModel()))
    }
}
