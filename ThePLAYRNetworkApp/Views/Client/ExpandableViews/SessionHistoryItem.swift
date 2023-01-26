//
//  SessionHistoryItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 12/8/22.
//

import SwiftUI

struct SessionHistoryItem: View {
    var body: some View {
        VStack(spacing: -15) {
            VStack(alignment: .leading){
                HStack {
                    Text("Back to Basics")
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                    
                    Text("Paid")
                        .font(.system(size: 16))
                        .foregroundColor(Color.ui.green)
                }
                VStack(alignment: .leading,spacing: -5){
                    HStack {
                        Text("Sunday, July 9")
                            .font(.system(size: 12))
                        Text(".")
                            .font(.title)
                            .bold()
                            .offset(y: -7)
                        
                        Text("11:00am-12pm")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.black)
                    
                    Text("Gym Name, San Diego")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                }
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.ui.grayF6F6F6)
                    .shadow(color: Color.ui.grayD9D9D9, radius: 1, x: 0, y: 5)
            )
            .padding()
            
            
            
            
            VStack(alignment: .leading){
                HStack {
                    Text("Strategy")
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                    
                    Text("Paid")
                        .font(.system(size: 16))
                        .foregroundColor(Color.ui.green)
                }
                VStack(alignment: .leading,spacing: -5){
                    HStack {
                        Text("Sunday, July 9")
                            .font(.system(size: 12))
                        Text(".")
                            .font(.title)
                            .bold()
                            .offset(y: -7)
                        
                        Text("11:00am-12pm")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.black)
                    
                    Text("Gym Name, San Diego")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                }
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.ui.grayF6F6F6)
                    .shadow(color: Color.ui.grayD9D9D9, radius: 1, x: 0, y: 5)
            )
            
            .padding()
            
            
        }
        
    }
}

struct SessionHistoryItem_Previews: PreviewProvider {
    static var previews: some View {
        SessionHistoryItem()
    }
}
