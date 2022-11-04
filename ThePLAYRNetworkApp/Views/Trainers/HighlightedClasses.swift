//
//  HighlightedClasses.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 10/4/22.
//

import SwiftUI

struct HighlightedClasses: View {
    var body: some View {
        
        VStack (alignment: .leading) {
            Text("Highlighted Classes")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, -2)
            
            
            //first HStack
            HStack {
                //First card
                ZStack(alignment: .bottomLeading){
                    Image("powerLifting")
                        .resizable()
                        .opacity(0.65)
                        .frame(width: 180, height: 126)
                    
                    VStack(alignment: .leading,spacing: 2){
                        Text("Powerlifting")
                            .font(.system(size: 16))
                            .bold()
                        
                        HStack(spacing: 3) {
                            Text("Mon-Wed")
                                .font(.system(size: 12))
                            Circle()
                                .frame(width:3, height:3)
                                .fontWeight(.bold)
                            Text("10:00 am")
                                .font(.system(size: 12))
                            
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.leading, 5)
                    .padding(.bottom, 5)
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                .shadow(radius: 3)
                
                
                
                
                
                //Second Card
                ZStack(alignment: .bottomLeading){
                    Image("hypertrophyTraining")
                        .resizable()
                        .opacity(0.65)
                        .frame(width: 180, height: 126)
                    
                    VStack(alignment: .leading,spacing: 2){
                        Text("Hypertrophy Training")
                            .font(.system(size: 16))
                            .bold()
                        
                        HStack(spacing: 3) {
                            Text("Tue")
                                .font(.system(size: 12))
                            Circle()
                                .frame(width:3, height:3)
                                .fontWeight(.bold)
                            Text("11:30 am")
                                .font(.system(size: 12))
                            
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.leading, 5)
                    .padding(.bottom, 5)
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                .shadow(radius: 3)
                
            }
            .padding(.bottom, 5)
            
            
            
            //second HStack
            HStack {
                //third card
                ZStack(alignment: .bottomLeading){
                    Image("strengthBuild")
                        .resizable()
                        .opacity(0.65)
                        .frame(width: 180, height: 126)
                    
                    VStack(alignment: .leading,spacing: 2){
                        Text("Strength Build")
                            .font(.system(size: 16))
                            .bold()
                        
                        HStack(spacing: 3) {
                            Text("Sat")
                                .font(.system(size: 12))
                            Circle()
                                .frame(width:3, height:3)
                                .fontWeight(.bold)
                            Text("5:00 pm")
                                .font(.system(size: 12))
                            
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.leading, 5)
                    .padding(.bottom, 5)
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                .shadow(radius: 3)
                
                
                VStack {
                    
                    ZStack(alignment: .center) {
                        Rectangle()
                            .frame(width: 180, height: 54)
                            .foregroundColor(Color("AccentColor"))
                            .cornerRadius(5)
                        
                        
                        Button {
                            
                        } label: {
                            VStack(alignment: .leading) {
                                Text("Request Custom")
                                Text("Session")
                            }
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
            }
            
            //View all classes
            
            HStack {
                Text("View all classes")
                Image(systemName: "chevron.right")
            }
            .font(.system(size: 16))
            .foregroundColor(Color("AccentColor"))
            
        }
    }
}

struct HighlightedClasses_Previews: PreviewProvider {
    static var previews: some View {
        HighlightedClasses()
    }
}
