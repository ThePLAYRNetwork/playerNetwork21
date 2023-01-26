//
//  SessionItemTrainers.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 10/6/22.
//

import SwiftUI

struct SessionItemTrainers: View {
    var body: some View {
        
        //ScrollView{
            VStack (alignment: .leading){
                HStack(alignment: .top) {
                    Image(systemName: "circle")
                        //.foregroundColor(Color.ui.accent)
                        .frame(width: 20, height: 20)
                    
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Powerlifting")
                            .fontWeight(.semibold)
                        
                        HStack{
                            Text("1 hour")
                            Circle()
                                .foregroundColor(.black)
                                .frame(width: 4, height: 4)
                            Text("$50")
                            
                        }
                        
                        
                        Text("Shorted description of the event. Clicking on the comment would redirect to session page to view more info, like long Instgram captions.")
                          // .multilineTextAlignment(.leading)
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                            .frame(width: 340)

                    }
                }
                
            }
            
            
            
            
            
            VStack (alignment: .leading){
                HStack(alignment: .top) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color.ui.accent)
                        .frame(width: 20, height: 20)
                    
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Hypertrophy Training")
                            .fontWeight(.semibold)
                        
                        HStack{
                            Text("1 hour")
                            Circle()
                                .foregroundColor(.black)
                                .frame(width: 4, height: 4)
                            Text("$50")
                            
                        }
                        
                        
                        Text("Shorted description of the event. Clicking on the comment would redirect to session page to view more info, like long Instgram captions.")
                          // .multilineTextAlignment(.leading)
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                            .frame(width: 340)

                        
                    }
                }
                
            }

    }
}

struct SessionItemTrainers_Previews: PreviewProvider {
    static var previews: some View {
      //  SessionItemTrainers()
        CapsuleTime()
    }
}



struct CapsuleTime: View {
    
    @State var capsuleCount = 3
    @State var selectedTime = true
    @State var time = "3:00 pm"
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 15) {
                
                
                ForEach(0..<capsuleCount, id: \ .self) { capsule in
                    
                    ZStack {
                        Capsule(style: .continuous)
                            .strokeBorder(selectedTime ? .clear : .gray)
                            .background(
                                Capsule()
                                    .foregroundColor(selectedTime ? Color.ui.accent : .clear)
                            )
         
                            .frame(width: 105, height: 26)
                      
                        Text(time)
                            .foregroundColor(selectedTime ? .white : .gray)
                        
                    }
                    
                }
            
            }
            .padding(.leading)
            .padding(.vertical, 0)
        }
    }
}
