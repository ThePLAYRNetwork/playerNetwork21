//
//  currentBookingsView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/15/22.
//

import SwiftUI

struct CurrentBookingsView: View {
    

    @Binding var selectedDay: Int
    let days = ["Mon 2", "Tue 3", "Wed 4", "Thu 5"]
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Bookings")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .padding(.leading, 20)
                    .padding(.top, 5)
                    .padding(.bottom, -5)
                
                
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
                            .underline(isSelected ? true : false, color: Color.ui.accentColor)
                          
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
                
                
                DefenseTrainingRowView()
            }
            .padding(.horizontal)
        }
    }
}

//struct currentBookingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentBookingsView()
//    }
//}
