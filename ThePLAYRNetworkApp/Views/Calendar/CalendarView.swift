//
//  CalendarView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/15/22.
//

import SwiftUI

struct CalendarView: View {
    
    @State var currentDate: Date = Date()
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Schedule")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                CustomDatePicker(currentDate: $currentDate)
                
                Divider()
                
                //VStack {
                //    ForEach (0...1, id: \.self) { row in
                
                HStack{
                    
                    VStack(spacing:5){
                        Text("20")
                            .fontWeight(.bold)
                        Text("WED")
                            .font(.caption)
                    }
                    
                    VStack {
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color("orange"))
                                .frame(maxWidth: .infinity, maxHeight: 70)
                                .cornerRadius(10)
                            
                            VStack(alignment: .leading) {
                                Text("5:30 pm - 8:00 pm")
                                    .font(.caption)
                                Text("Open Gym")
                                    .font(.body)
                                Text("Main Gym")
                                    .font(.caption2)
                            }
                            .padding()
                            
                        }
                        
                    }
                }
                
                
                HStack{
                    
                    VStack(spacing:5){
                        Text("20")
                            .fontWeight(.bold)
                        Text("WED")
                            .font(.caption)
                    }
                    
                    VStack {
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color("orange"))
                                .frame(maxWidth: .infinity, maxHeight: 70)
                                .cornerRadius(10)
                            
                            VStack(alignment: .leading) {
                                Text("5:30 pm - 8:00 pm")
                                    .font(.caption)
                                Text("Open Gym")
                                    .font(.body)
                                Text("Main Gym")
                                    .font(.caption2)
                            }
                            .padding()
                            
                        }
                        
                    }
                }
                
                
                
                
                HStack{
                    
                    VStack(spacing:5){
                        Text("20")
                            .fontWeight(.bold)
                        Text("WED")
                            .font(.caption)
                    }
                    
                    VStack {
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color("purple"))
                                .frame(maxWidth: .infinity, maxHeight: 70)
                                .cornerRadius(10)
                            
                            VStack(alignment: .leading) {
                                Text("5:30 pm - 8:00 pm")
                                    .font(.caption)
                                Text("Open Gym")
                                    .font(.body)
                                Text("Main Gym")
                                    .font(.caption2)
                            }
                            .padding()
                            
                        }
                        
                    }
                }
                
                HStack{
                    
                    VStack(spacing:5){
                        Text("20")
                            .fontWeight(.bold)
                        Text("WED")
                            .font(.caption)
                    }
                    
                    VStack {
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color("orange"))
                                .frame(maxWidth: .infinity, maxHeight: 70)
                                .cornerRadius(10)
                            
                            VStack(alignment: .leading) {
                                Text("5:30 pm - 8:00 pm")
                                    .font(.caption)
                                Text("Open Gym")
                                    .font(.body)
                                Text("Main Gym")
                                    .font(.caption2)
                            }
                            .padding()
                            
                        }
                        
                    }
                }
                
                
                HStack{
                    
                    VStack(spacing:5){
                        Text("20")
                            .fontWeight(.bold)
                        Text("WED")
                            .font(.caption)
                    }
             
                    VStack {
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color("orange"))
                                .frame(maxWidth: .infinity, maxHeight: 70)
                                .cornerRadius(10)
                            
                            VStack(alignment: .leading) {
                                Text("5:30 pm - 8:00 pm")
                                    .font(.caption)
                                Text("Open Gym")
                                    .font(.body)
                                Text("Main Gym")
                                    .font(.caption2)
                            }
                            .padding()
                            
                        }
                        
                    }
                }
                //    }
                //            }
                //            .padding()
                
                Spacer()
            }
            
            .padding()
        }
    }
    
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
