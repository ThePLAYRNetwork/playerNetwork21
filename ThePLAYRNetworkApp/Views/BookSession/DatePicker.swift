//
//  DatePicker.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/23/22.
//

import Foundation
import SwiftUI

struct DatePicker: View {
    @Binding var currentDate2: Date
    @State var currentMonth2 : Int = 0
    @State var currentDay: Int = 0
    
    //Days..
    let days: [String] =
    ["S", "M","T","W", "T", "F","S"]
    
    
    var body: some View {
        VStack(spacing: 10) {
            
            HStack {
                Text(extraDate()[1] + " " + extraDate()[0])
                    .font(.body.bold())
                
                Spacer()
                
                Button {
                    withAnimation {
                        currentDay -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                 
                }
                
                
                
                Text("Today")
                
                Button {
                    withAnimation {
                        currentDay -= 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                    
                }
                
            }
            .padding(.horizontal, 0)
            
            //Day View...
            
            HStack(spacing: 0) {
                ForEach(days,id: \.self) {day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom)
            // Dates....
            // Lazy Grid..
            
            let columns =  Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns) {
                
                ForEach(extractDate()){value in
                    
                    CardView2(value: value)
                        .frame(height: 35)
                        .background(
                            Circle()
                                .fill(Color("purple"))
                                .frame(width:40, height:40)
                                .opacity(isSameDay(date1: value.date, date2:
                                                    currentDate2) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate2 = value.date
                            
                        }
                }
            }
            
            
            
            
        }
        .onChange(of: currentMonth2) { newValue in
            // updating Month...
            currentDate2 = getCurrentMonth()
        }
    }
    
    
    @ViewBuilder
    func CardView2(value: DateValue)->some View{
        
        VStack{
            
            if value.day != -1{
                
                if let task = tasks.first(where: { task in
                    
                    return isSameDay(date1: task.taskDate, date2:
                                        value.date)
                }) {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.taskDate, date2: currentDate2) ?
                            .white : .primary)
                        .frame(maxWidth: .infinity, maxHeight: 400)
                    
                    Spacer()
                    
                    Circle()
                        .fill(isSameDay(date1: task.taskDate,
                                        date2: currentDate2) ? .white :
                                Color("Pink"))
                        .frame(width: 8, height: 8)
                }
                else {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate2) ?
                            .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
            }
        }
        .padding(.vertical,9)
        .frame(height: 60, alignment: .top)
    }
    
    
    // checking dates...
    func isSameDay(date1: Date, date2: Date)->Bool{
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func extraDate()->[String]{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate2)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth()->Date{
        let calendar = Calendar.current
        
        //Getting Current Month Date...
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth2, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    
    
    func getCurrentDay()->Date{
        let calendar = Calendar.current
        
        //Getting Current Month Date...
        guard let currentDay = calendar.date(byAdding: .day, value: self.currentDay, to: Date()) else {
            return Date()
        }
        return currentDay
    }
    
    func getYesterday()->String {
        let date = Date()
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: date)
        return "\(yesterday!.formatted(.dateTime.day()))"
    }
    
    
    func getTomorrow()->String{
        let date = Date()
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: +1, to: date)
        return "\(tomorrow!.formatted(.dateTime.day()))"
    }
    
    
    
    func extractDate()->[DateValue]{
        
        let calendar = Calendar.current
        
        //Getting Current Month Date...
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date
            -> DateValue in
            
            //getting day...
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday,
                                              from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
    
}

//struct CustomDatePicker_Previews: PreviewProvider {
//    @State var currentDate1: Date = Date()
//
//    static var previews: some View {
//        CustomDatePicker(currentDate: $currentDate1)
//    }
//}

// Extending Date to get Current Month Dates...
extension Date {
    
    func getAllDates2()->[Date]{
        
        let calendar = Calendar.current
        
        // getting start Date...
        let startDate = calendar.date(from:
                                        Calendar.current.dateComponents([.year, .month], from: self))!
        
        var range = calendar.range(of: .day, in: .month, for: startDate)!
        range.removeLast()
        
        //getting date...
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
