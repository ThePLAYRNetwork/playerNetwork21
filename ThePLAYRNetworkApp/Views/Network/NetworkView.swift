//
//  NetworkView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/4/22.
//

import SwiftUI

// TODO: Add divider
struct NetworkView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var networkViewModel: NetworkViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                TopSearchBarSection()
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        divider
                            .padding(.bottom, 30)

                        
                        HStack{
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray.opacity(0.3))
                            
                            
                            Text("What's on your mind?")
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal)
                        
                        divider
                            .padding(.top, 30)
                        
                        // PlayersYouMayKnowRow()
                        
                        ForEach($networkViewModel.posts) { $post in
                            PostItem(post: $post)
                            divider
                        }
                    }
                }
            }
        }
        .navigationTitle("")
        .toolbar {
            ToolbarItem {
                Button {
                    // Navigate to create post view
                    navigationModel.homePath.append(PostDestination.createPost)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .refreshable {
            Task {
                await networkViewModel.fetchPosts()
            }
        }
    }
}

var divider: some View {
    Rectangle()
        .frame(height: 7)
        .foregroundColor(Color.ui.grayD9D9D9)
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NetworkView()
                .environmentObject(NavigationModel())
                .environmentObject(NetworkViewModel())
        }
    }
}

