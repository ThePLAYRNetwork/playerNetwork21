////
////  CustomDatePicker.swift
////  ThePLAYRNetworkApp
////
////  Created by Mirna Helmy on 8/15/22.
////
//
import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0
    //Days..
    let days: [String] =
    ["S", "M","T","W", "T", "F","S"]
    
    
    var body: some View {
        VStack(spacing: 10) {
            //Months
            HStack(alignment: .center){
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Text(getPreviousMonth().uppercased())
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                Spacer()
                
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Text(getMyCurrentMonth().uppercased())
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                Spacer()
                
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    // Image(systemName: "chevron.right")
                    Text(getNextMonth().uppercased())
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                Spacer()
                
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Text(getFollowingMonth().uppercased())
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                
            }
            
            .padding(.horizontal)
            .padding(.bottom)
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
            
                                CardView(value: value)
                                    .frame(height: 35)
                                    .background(
                                        Circle()
                                            .fill(Color("red"))
                                            .frame(width:40, height:40)
                                            .opacity(isSameDay(date1: value.date, date2:
                                                                currentDate) ? 1 : 0)
                                    )
                                    .onTapGesture {
                                        currentDate = value.date
                                          
                                    }
                            }
                        }
            
            
            /*
             //   VStack(spacing: 15) {
             
             //IMPORTANT***
             //                if let task = tasks.first(where: { task in
             //                    return isSameDay(date1: task.taskDate, date2: currentDate)
             //                }) {
             //
             //
             //                    ForEach(task.task){task in
             //
             //                        VStack(alignment: .leading, spacing: 10) {
             //
             //                            // For Custom Timing...
             //                            Text(task.time
             //                                .addingTimeInterval(CGFloat
             //                                    .random(in: 0...5000)), style:
             //                                    .time)
             //                            Text(task.title)
             //                                .font(.title2.bold())
             //
             //                        }
             //                        .padding(.vertical,10)
             //                        .padding(.horizontal)
             //                        .frame(maxWidth: .infinity , alignment: .leading)
             //                        .background(
             //                            Color("orange")
             //                                .opacity(0.5)
             //                                .cornerRadius(10)
             //                        )
             //                    }
             //
             //                } else {
             //
             //                }
             
             
             }
             */
            
        }
        .onChange(of: currentMonth) { newValue in
            // updating Month...
            currentDate = getCurrentMonth()
        }
    }
    
    
    @ViewBuilder
    func CardView(value: DateValue)->some View{
        
        VStack{
            
            if value.day != -1{
                
                if let task = tasks.first(where: { task in
                    
                    return isSameDay(date1: task.taskDate, date2:
                                        value.date)
                }) {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.taskDate, date2: currentDate) ?
                            .white : .primary)
                        .frame(maxWidth: .infinity, maxHeight: 400)
                    
                    Spacer()
                    
                    Circle()
                        .fill(isSameDay(date1: task.taskDate,
                                        date2: currentDate) ? .white :
                                Color("Pink"))
                        .frame(width: 8, height: 8)
                }
                else {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ?
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
    
    
    func getCurrentMonth()->Date{
        let calendar = Calendar.current
        
        //Getting Current Month Date...
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
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
    
    func getPreviousMonth()->String{
        let date = Date()
        let calendar = Calendar.current
        let previousMonth = calendar.date(byAdding: .month, value: -1, to: date)
        return "\(previousMonth!.formatted(.dateTime.month()))"
    }
    
    func getMyCurrentMonth()->String{
        let date = Date()
        let calendar = Calendar.current
        let currentMonth = date.formatted(.dateTime.month())
        return String(currentMonth)
    }
    
    func getNextMonth()->String{
        let date = Date()
        let calendar = Calendar.current
        let nextMonth = calendar.date(byAdding: .month, value: +1, to: date)
        return "\(nextMonth!.formatted(.dateTime.month()))"
    }
    
    func getFollowingMonth()->String{
        let date = Date()
        let calendar = Calendar.current
        let followingMonth = calendar.date(byAdding: .month, value: +2, to: date)
        return "\(followingMonth!.formatted(.dateTime.month()))"
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
    
    func getAllDates()->[Date]{
        
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
