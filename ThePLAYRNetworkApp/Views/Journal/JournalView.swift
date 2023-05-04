//
//  JournalView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 10/21/22.
//

import SwiftUI

// Proposal: have court item represent a single date and used for inputting while chart is used to represent a range of data
// - hard to calculate start and end dates given a date.
// - hard to add it all and show it on court and have everything consistent
struct JournalView: View {
    // state object owns it, observed object just watches the state object?
    @EnvironmentObject var journalViewModel: JournalViewModel
    @State var sunday = Date()
    @State var saturday = Date()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Text("Journal")
                    .font(.system(size: 24, weight: .semibold))
                    .padding(.bottom, 9)
                
                
                TabView {
                    CourtTabItem(isHeatMap: false)
                    CourtTabItem(isHeatMap: true)
                    JournalChartTabItem()
                }
                .tabViewStyle(.page(indexDisplayMode: .never)) // .always
                .frame(height: 430)
                //                    .border(.green)
                .padding(.bottom, 20)
                
                VStack(alignment: .leading, spacing: 0) {
                    CustomSegmentedControl(
                        selectedIndex: $journalViewModel.selectedNotes,
                        options: ["Notes", "Drills", "Trends"],
                        spacing: 0
                    )
                    .font(.system(size: 12))
                    .padding(.bottom, 15)
                    
                    // Replace Text
                    if journalViewModel.selectedNotes == 0 {
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                    } else if journalViewModel.selectedNotes == 1 {
                        Text("Showing Drills")
                    } else {
                        Text("Showing Trends")
                    }
                    
                    HStack {
                        Text(sunday.formatted(date: .abbreviated, time: .omitted))
                        Text(saturday.formatted(date: .abbreviated, time: .omitted))
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "list.bullet")
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image("camera")
                                .resizable()
                                .frame(width: 21, height: 18)
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image("pencil")
                                .resizable()
                                .frame(width: 17.5, height: 18)
                        }
                    }
                    .padding(.top)
                }
                .frame(height: 200)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 17)
                        .fill(Color.ui.grayF6F6F6)
                }
                
                Spacer()
            }
            .padding()
        }
        .onReceive(journalViewModel.$selectedDate) { newValue in
            Task {
                if journalViewModel.selectedDateRange == .day {
                    await journalViewModel.getJournalEntry(date: newValue)
                } else {
                    let (startDate, endDate) = getSundayAndSaturday(for: newValue)
                    // Fetch journal entry using new date
                    await journalViewModel.getJournalEntry(startDate: startDate, endDate: endDate)
                }
            }
        }
        .onReceive(journalViewModel.$selectedDateRange) { newValue in
            Task {
                switch newValue {
                case .day:
                    await journalViewModel.getJournalEntry(date: journalViewModel.selectedDate)
                case .week:
                    let (startDate, endDate) = getSundayAndSaturday(for: journalViewModel.selectedDate)
                    await journalViewModel.getJournalEntry(startDate: startDate, endDate: endDate)

                    self.sunday = startDate
                    self.saturday = endDate
                default:
                    print("Other date range")
                    return
                }
            }
        }
    }
}

// Assuming order is sunday, monday, tuesday
func getSundayAndSaturday(for date: Date) -> (Date, Date) {
    let calendar = Calendar.current
    let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
    let sunday = calendar.date(byAdding: .day, value: 1 - calendar.component(.weekday, from: startOfWeek), to: startOfWeek)!
    let saturday = calendar.date(byAdding: .day, value: 7 - calendar.component(.weekday, from: startOfWeek), to: startOfWeek)!
    return (sunday, saturday)
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
            .environmentObject(JournalViewModel(journalRepository: JournalRepository()))
    }
}

enum DateRange: String, CaseIterable, Identifiable {
    case day, week, month, year
    var id: Self { self }
    
    var intials: String {
        switch self {
        case .day:
            return "D"
        case .week:
            return "W"
        case .month:
            return "M"
        case .year:
            return "Y"
        }
    }
}


struct JournalCustomSegmentedControl: View {
    @Binding var selectedDateRange: DateRange
    let color = Color.black
    let spacing: CGFloat
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(DateRange.allCases) { dateRange in
                let isSelected = selectedDateRange == dateRange
                
                Text(dateRange.intials)
                    .font(.system(size: 12, weight: .semibold))
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                    .background(Capsule().fill(isSelected ? Color.ui.black : .clear))
                    .foregroundColor(isSelected ? .white : .red)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(
                            response: 0.1, dampingFraction: 1.5, blendDuration: 0.5)) {
                                selectedDateRange = dateRange
                            }
                    }
            }
        }
        .background {
            Capsule().fill(Color.ui.grayDADADA)
        }
    }
}
