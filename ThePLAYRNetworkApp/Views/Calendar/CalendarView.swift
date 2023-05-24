//
//  CalendarView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 1/9/23.
//

import SwiftUI

// TODO: 1. Add sessions (use enum, see bookmark)
// TODO: 2. Change game date to have only 1 date instead of 3 seperate dates. (can infer end date with some duration by offseting start date)
// TODO: 3. Calendar
struct CalendarView: View {
    @EnvironmentObject var calendarViewModel: CalendarViewModel
    @State var uniqueDates: [Date] = []
    
    func getStartDay(date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        return components.day?.description ?? "N/A"
    }
    
    func dayOfWeek(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // Wed
        let dayOfWeek = formatter.string(from: date)
        return dayOfWeek
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                CalendarTrainerView(interval: DateInterval(start: .distantPast, end: .distantFuture))
                
                Divider()
                
                ForEach(uniqueDates.sorted(by: { $0 < $1 }), id: \.self) { date in
                    HStack(alignment: .top) {
                        VStack {
                            Text(getStartDay(date: date))
                                .font(.system(size: 28))
                                .fontWeight(.semibold)
                            
                            Text(dayOfWeek(date: date).uppercased())
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                        }
                        .frame(width: 40)
                        
                        VStack {
//                            ForEach(Game.sampleGames.sorted(by: { $0.date < $1.date })) { game in
//                                if sameDay(d1: date, d2: game.date) {
//                                    EventItem(game: game)
//                                        .opacity(isPastDate(someDate: game.date) ? 0.7 : 1.0)
//                                }
//                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            
        }
        .onAppear {
            self.uniqueDates = getUniqueDates()
        }
    }
    
    func isPastDate(someDate: Date) -> Bool {
        let currentDate = Date()
        return someDate.compare(currentDate) == .orderedAscending
    }
    
    func getUniqueDates() -> [Date] {
        var dates = Game.sampleGames.map { $0.date }
        let uniqueDates = dates.reduce(into: [Date]()) { result, date in
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
            let day = Calendar.current.date(from: dateComponents)!
            if !result.contains(day) {
                result.append(day)
            }
        }
        return uniqueDates
    }
    
    func sameDay(d1: Date, d2: Date) -> Bool {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: d2)
        let d2New = Calendar.current.date(from: dateComponents)!
        return d1 == d2New
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(CalendarViewModel(gameRepository: GameRepository()))
        
    }
}
