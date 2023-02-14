//
//  ConversationBottomView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/25/22.
//

import SwiftUI

struct ConversationBottomView: View {
    @State var message: String = ""
    @State var showFileOptions: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            
            Divider()
            
            HStack(alignment: .center, spacing: 10) {
                Button(action: { showFileOptions.toggle() }) {
                    Image(systemName: "paperclip")
                        .frame(height: 24)
                }

                Image(systemName: "camera.fill")
                    .frame(height: 24)

                TextField("Write a message...", text: $message, axis: .vertical)
                    .padding(7)
                    .background(.regularMaterial)
                    .font(.system(size: 14))
                
                Image(systemName: "mic.fill")
                    .frame(height: 24)

            }
            .font(.system(size: 24))
            .foregroundColor(Color.ui.gray959595)
            .padding()
            
            if showFileOptions {
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image("send_document")
                                .resizable()
                                .frame(width: 12, height: 16.8)
                            Text("Send a document")
                        }
                        
                        HStack {
                            Image("send_photo")
                                .resizable()
                                .frame(width: 18, height: 13)
                            Text("Send a photo or video")
                        }
                        
                        HStack {
                            Image("send_gif")
                                .resizable()
                                .frame(width: 18, height: 15)
                            Text("Send a GIF")
                        }
                        
                        
                    }
                    .padding()
                    .padding(.horizontal)
                    Spacer()
                }
                .font(.system(size: 14))
            }
            
        }
    }
}

struct ConversationBottomView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationBottomView()
//            .border(.red)
    }
}
