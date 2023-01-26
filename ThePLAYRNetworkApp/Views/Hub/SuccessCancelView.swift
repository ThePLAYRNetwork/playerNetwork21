//
//  SuccessCancelView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/16/22.
//

import SwiftUI

struct SuccessCancelView: View {
    @State private var showingAlert: Bool = false

    
    @Binding var selectedDay: Int
    let days = ["Mon 2", "Tue 3", "Wed 4", "Thu 5"]
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack(alignment: .leading) {
                    Text("Booked Sessions")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, 25)
                        .padding(.bottom, 5)
                    
                    CalendarTrainerView(interval: DateInterval(start: .distantPast, end: .distantFuture))
                        .padding(.horizontal)
                        .frame(height: 370)
                    
                    
                    HStack {
                        Spacer()
                        ForEach(days.indices, id: \.self) { day in
                            let isSelected = selectedDay == day
                            
                            Text(days[day])
                                .foregroundColor(isSelected ? .black : Color.ui.gray959595)
                                .fontWeight(isSelected ? .semibold : .regular)
                                .underline(isSelected ? true : false, color: Color.ui.primary)
                            
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(
                                        response: 0.1, dampingFraction: 1.5, blendDuration: 0.5)) {
                                            selectedDay = day
                                        }
                                    
                                }
                            
                            Spacer()
                        }
                        Spacer()
                        
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading){
                        
                        Text("Defense Training")
                            .font(.system(size: 16, weight: .semibold))
                        
                        HStack {
                            Text("Tuesday, August 2")
                            
                            
                            Circle()
                                .frame(width: 2, height: 2)
                            
                            Text("10:00am - 11:00am")
                        }
                        .foregroundColor(Color.ui.gray959595)
                        
                        HStack {
                            Text("Booked by")
                                .foregroundColor(Color.ui.gray959595)
                            
                            
                            Text("Alex Allens")
                                .foregroundColor(.black)
                            
                        }
                        
                        
                        HStack{
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("More Details")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .frame(width: 131, height: 33)
                                    .background(.black)
                                    .background(in: RoundedRectangle(cornerRadius: 5))
                                
                            }
                            
                            
                            
                            
                            Button {
                                showingAlert.toggle()
                                
                            } label: {
                                Text("Cancel Session")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .frame(width: 131, height: 33)
                                    .background(Color.ui.primary)
                                    .background(in: RoundedRectangle(cornerRadius: 5))
                            }
                        }
                       
                    }
                    .padding(.horizontal)
                    .padding()
                }
            }
            .background(showingAlert ? Color.ui.black_light : .clear)
            if showingAlert {
                AlertView(showingAlert: $showingAlert)
            }
        }
    }
}

//struct SuccessCancelView_Previews: PreviewProvider {
//    static var previews: some View {
//        SuccessCancelView()
//    }
//}
