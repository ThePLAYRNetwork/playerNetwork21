//
//  NetworkView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/4/22.
//

import SwiftUI

// TODO:
//  - Infinite scrolling  (done)
//  - Network feed is currenlty ALL post (bc smaller community, more like forum)
//  - Change 'share' to 'repost', with text above saying "reposted by"

struct NetworkView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var networkViewModel: NetworkViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                TopSearchBarSection()
                
                LazyVStack(spacing: 0) {
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
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    divider
                        .padding(.top, 30)
                    
                    // PlayersYouMayKnowRow()
                    
                    ForEach(networkViewModel.postViewModels) { postViewModel in
                        PostItem(postViewModel: postViewModel)
                        divider
                    }
                    
                    if let cursor = networkViewModel.cursor {
                        ProgressView()
                            .padding(.top)
                            .onAppear {
                                Task {
                                    networkViewModel.postViewModels.append(contentsOf: await networkViewModel.fetchPosts(cursor: cursor))
                                }
                            }
                    }
                    
                }
            }
        }
        .navigationTitle("Home")
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
                networkViewModel.postViewModels = await networkViewModel.fetchPosts()
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

