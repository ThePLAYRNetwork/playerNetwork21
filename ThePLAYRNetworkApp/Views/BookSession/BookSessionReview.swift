//
//  BookSessionReview.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 1/15/23.
//

import SwiftUI

struct BookSessionReview: View {
    @State var session: Session
    
    var body: some View {
        ZStack(alignment: .bottom) {
    
            VStack(alignment: .leading, spacing: 0) {
                Image("powerLifting")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 410,height: 141)
                    .clipped()
                   .ignoresSafeArea()
                    .opacity(0.6)
              
                
                SessionInfo(session: Session(sessionTitle: ""))
                    .padding(.top, -30)
                    .padding(.horizontal)
                           
                Divider()
                    .padding(.vertical, 2)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Session Information".uppercased())
                            .font(.system(size: 14))
                            .foregroundColor(Color.ui.subheading_text)
                            .padding(.leading, 20)
                            .padding(.top, 27)
                        
                        BookSessionCell()
                            .padding(.leading, 40)
                            .padding(.top, 20)
                    }
                }
        }
        .padding(.horizontal)
            
            VStack {
                Divider()
                
                HStack {
                    Text("$50")
                        .foregroundColor(.black)
                        .padding(.leading, 40)
                    
                    Spacer()
                    NavigationLink(destination: {  }) {
                        Text("Book Training")
                            .foregroundColor(.white)
                            .frame(width:143, height:33)
                            .background(Color("AccentColor"))
                            .cornerRadius(5)
                    }
                    
                    
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(.black)
                        .foregroundColor(.white)
                        .frame(width: 36, height: 33)
                        .overlay(
                            Image("turn.up.right")
                                .resizable()
                                .frame(width: 20, height: 18.33)
                              
                        )
                    
                }
                .frame(height:72)
                .padding(.trailing, 40)
                .padding(.horizontal)
            }
            .background(.white)
            .frame(height: 50)
            
        }

    }
}

struct BookSessionReview_Previews: PreviewProvider {
    static var previews: some View {
        BookSessionReview(session: Session(sessionTitle: ""))
    }
}
