//
//  ProfileView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 8/3/22.
//

import SwiftUI

struct ProfileView: View {
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
                
                ForEach($posts, id: \.id) { $post in
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
    }
}

extension ProfileView {
    struct TopSection: View {
        var body: some View {
            HStack(spacing: 20) {
                Circle()
                    .fill(Color.ui.grayD9D9D9)
                    .frame(width: 115)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Your Name")
                        .bold()
                        .font(.system(size: 24))
                    
                    Text("**Highest Level:** College")
                        .padding(.top, 4)
                    
                    Text("**Plays Like:** Lebron James")
                        .padding(.top, 7)
                }
                
                Spacer()
            }
        }
    }
    
    struct PlayerStats: View {
        var body: some View {
            HStack {
                VStack {
                    Text("6'2\"")
                        .bold()
                    Text("Height")
                        .font(.system(size: 12))
                }
                
                Spacer()
                
                VStack {
                    Text("180 lbs")
                        .bold()
                    Text("Weight")
                        .font(.system(size: 12))
                }
                
                Spacer()
                
                VStack {
                    Text("Forward")
                        .bold()
                    Text("Position")
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
}
