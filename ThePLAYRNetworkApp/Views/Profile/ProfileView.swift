//
//  ProfileView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 8/3/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var ckUserViewModel: CloudKitUserViewModel
    @State var posts = Post.samplePosts
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                TopSection()
                    .padding(.top)
                    .padding(.horizontal)
                
                PlayerStats()
                    .padding(.horizontal, 60) // to center under
                    .padding(.top)
                
                ProfileButtons()
                    .padding(.top, 20)
                    .padding(.horizontal)
                
                Divider()
                    .padding(.top, 20)
                
                PlayerAttributes()
                    .padding()
                
                ProfileMedia()
                
                // Posts
                Text("Posts")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.leading)
                    .padding(.top)
                
                ForEach($posts, id: \.recordName) { $post in
                    PostItem(post: $post)
                    divider
                }
                
                Spacer()
            }
            .padding(.top)
        }
        .background(Color.ui.whiteBg)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(CloudKitUserViewModel(userRepository: UserRepository(), navigationModel: NavigationModel()))
    }
}


struct TopSection: View {
    @EnvironmentObject var ckUserViewModel: CloudKitUserViewModel

    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: ckUserViewModel.user.profileImage?.fileURL) { phase in
                if let image = phase.image {
                    // Success
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    // Error
                    Image(systemName: "person.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                } else {
                    // Loading
//                    ProgressView()
                }
            }
            .frame(width: 115, height: 115)
            .clipShape(Circle())
            .background {
                Circle().fill(Color.ui.grayD9D9D9)
            }

            
            
            
            VStack(alignment: .leading, spacing: 0) {
                Text(ckUserViewModel.user.name)
                    .bold()
                    .font(.system(size: 24))
                
                Text("**Highest Level:** \(ckUserViewModel.user.highestLevelPlayed.rawValue.capitalized)")
                    .padding(.top, 4)
                
                Text("**Plays Like:** \(ckUserViewModel.user.playsLike)")
                    .padding(.top, 7)
            }
            
            Spacer()
        }
    }
}

struct PlayerStats: View {
    @EnvironmentObject var ckUserViewModel: CloudKitUserViewModel

    var body: some View {
        HStack {
            VStack {
                Text(ckUserViewModel.user.height)
                    .bold()
                Text("Height")
                    .font(.system(size: 12))
            }
            
            Spacer()
            
            VStack {
                Text(ckUserViewModel.user.weight)
                    .bold()
                Text("Weight")
                    .font(.system(size: 12))
            }
            
            Spacer()
            
            VStack {
                Text("Forward")
                    .bold()
                Text(ckUserViewModel.user.position.rawValue.capitalized)
                    .font(.system(size: 12))
            }
        }
    }
}

struct ProfileButtons: View {
    var body: some View {
        VStack(spacing: 6) {
            Button(action: {}) {
                Text("Edit Profile")
                    .foregroundColor(.white)
                    .padding(.vertical, 7)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.ui.blackExtraBlack)
                    }
            }
            .buttonStyle(.plain)
            
            HStack(spacing: 7) {
                Button(action: {}) {
                    Text("Connections")
                        .foregroundColor(.white)
                        .padding(.vertical, 7)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.ui.blackExtraBlack)
                        }
                }
                .buttonStyle(.plain)
                
                Button(action: {}) {
                    Text("Store")
                        .foregroundColor(.white)
                        .padding(.vertical, 7)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.ui.blackExtraBlack)
                        }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

