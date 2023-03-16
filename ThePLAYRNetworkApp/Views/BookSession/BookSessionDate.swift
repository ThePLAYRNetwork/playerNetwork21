//
//  BookSessionDate.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 10/17/22.
//

import SwiftUI

struct BookSessionDate: View {
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
              
                
                SessionInfo(session: Session.sampleSessions[0])
                    .padding(.top, -30)
                    .padding(.horizontal)
           
                
                Divider()
                    .padding(.vertical, 2)
                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                Text("Select Date")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal,25)
                  
          
                    
                    CalendarTrainerView(interval: DateInterval(start: .distantPast, end: .distantFuture))
                        .padding(.horizontal)
                    
                 
                        Text("Select Time")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal,25)
                            .padding(.bottom, 0)
                        
                        
                        CapsuleTime()
                            .padding(.vertical,4)
                            .padding(.horizontal, 15)
                        CapsuleTime(capsuleCount: 1, selectedTime: false)
                            .padding(.vertical,4)
                            .padding(.horizontal, 15)
                            .padding(.bottom, 100)
                        Spacer()
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
//                    NavigationLink(destination: BookSessionReview(session: Session(sessionTitle: ""))) {
//                        Text("Book Training")
//                            .foregroundColor(.white)
//                            .frame(width:143, height:33)
//                            .background(Color("AccentColor"))
//                            .cornerRadius(5)
//                    }
                    
                    
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

//struct BookSessionDate_Previews: PreviewProvider {
//    static var previews: some View {
//        BookSessionDate()
//    }
//}
