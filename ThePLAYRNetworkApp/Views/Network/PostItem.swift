//
//  PostItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/4/22.
//

import SwiftUI

struct PostItem: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var postViewModel: PostViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                
                AsyncImage(url: postViewModel.post.author?.profileImage?.fileURL) { phase in
                    if let image = phase.image {
                        // Displays the loaded image./
                        image
                            .resizable()
                    } else {
                        // Acts as a placeholder.
                        Image(systemName: "person.fill")
                            .font(.system(size: 25))
                            .foregroundColor(Color.ui.grayECECEC)
                    }
                }
                .frame(width: 51, height: 51)
                .clipShape(Circle())
                .background {
                    Circle().fill(Color.ui.grayD9D9D9)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(postViewModel.post.author?.fullName ?? "User not found")
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 20))
                                .padding(4)
                        }
                        .buttonStyle(.plain)
                    }
                    Text("\(postViewModel.post.author?.position.rawValue.capitalized ?? "") @\(postViewModel.post.author?.school ?? "")")
                        .font(.system(size: 12))
                    Text("\(formatTwitterDate(postViewModel.post.createdAt))")
                        .font(.system(size: 12))
                }
            }
            
            Text(postViewModel.post.message)
                .padding(.top, 12)
            
            Rectangle()
                .frame(height: 200)
                .foregroundColor(Color.ui.grayD9D9D9)
                .padding(.top, 12)
            
            HStack {
                Circle()
                    .fill(Color.ui.grayD9D9D9)
                    .frame(width: 14, height: 14)
                
                Text("\(postViewModel.post.likes)")
                
                Spacer()
                
                Text("\(postViewModel.post.numberOfComments) comments")
            }
            .padding(.top, 16)
            .foregroundColor(.gray)
            .font(.system(size: 12))
            
            Divider()
                .padding(.top, 10)
            
            // to each vstack for even spacing -> .frame(maxWidth: .infinity)

            
            HStack(alignment: .bottom) {
                Button {
                    Task {
                        await postViewModel.onTappedLikeButton()
                    }
                } label: {
                    VStack {
                        Image(systemName: "hand.thumbsup")
                        Text("Like")
                    }
                    .foregroundColor(postViewModel.post.isLiked ? .accentColor : .gray)
                    .symbolVariant(postViewModel.post.isLiked ? .fill : .none)
                }
                
                Spacer()

                NavigationLink {
                    CommentsList(originalPost: postViewModel.post)
                        .environmentObject(postViewModel)
                } label: {
                    VStack {
                        Image(systemName: "message")
                        Text("Comment")
                    }
                }

                Spacer()
                
                VStack {
                    Image(systemName: "arrowshape.turn.up.right")
                    Text("Share")
                }
                
                Spacer()
                
                VStack {
                    Image(systemName: "paperplane")
                    Text("Send")
                }
            }
            .foregroundColor(.gray)
            .font(.system(size: 12))
            .padding(.horizontal)
            .padding(.top, 17)
            
        }
        .padding()
        .padding(.top)
    }
    
}

func formatTwitterDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Format of your input date
    
    let now = Date()
    let components = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute], from: date, to: now)
    
    if let year = components.year, year > 0 {
        return formatter.string(from: date)
    } else if let month = components.month, month > 0 {
        return formatter.string(from: date)
    } else if let weekOfYear = components.weekOfYear, weekOfYear > 0 {
        return "\(weekOfYear)w ago"
    } else if let day = components.day, day > 0 {
        return "\(day)d ago"
    } else if let hour = components.hour, hour > 0 {
        return "\(hour)h ago"
    } else if let minute = components.minute, minute > 0 {
        return "\(minute)m ago"
    } else {
        return "Now"
    }
}
struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        PostItem(postViewModel: PostViewModel(post: Post.samplePosts[0]))
            .previewLayout(.sizeThatFits)
    }
}
