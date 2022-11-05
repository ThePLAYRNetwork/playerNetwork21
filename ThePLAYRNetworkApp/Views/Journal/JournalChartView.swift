//
//  JournalChartView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/1/22.
//

import SwiftUI
import Charts

struct DailyScore: Identifiable {
    var id = UUID() // use cloudkit id in future.
    var category: String
    var score: Int
    var attempt: Int
    var date: Date
    
    init(category: String, score: Int, attempt: Int, year: Int, month: Int, day: Int) {
        let calendar = Calendar.autoupdatingCurrent
        self.category = category
        self.score = score
        self.attempt = attempt
        self.date = calendar.date(from: DateComponents(year: year, month: month, day: day))!
    }
}

var dailyScoreData: [DailyScore] = [
    DailyScore(category: "Right Corner", score: 5, attempt: 6, year: 2023, month: 10, day: 4),
    DailyScore(category: "Right Corner", score: 5, attempt: 7, year: 2023, month: 10, day: 5),
    DailyScore(category: "Right Corner", score: 6, attempt: 6, year: 2023, month: 10, day: 6),
    DailyScore(category: "Right Corner", score: 5, attempt: 7, year: 2023, month: 10, day: 7),
    DailyScore(category: "Right Corner", score: 8, attempt: 8, year: 2023, month: 10, day: 8),
    DailyScore(category: "Right Corner", score: 10, attempt: 10, year: 2023, month: 10, day: 9),
    DailyScore(category: "Right Corner", score: 8, attempt: 10, year: 2023, month: 10, day: 10)
]

// series used for disguinshing between lines. First part is just a description, second part is the distinguishable
struct JournalChartView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Right Corner")
                .font(.system(size: 16, weight: .medium))
            
            Chart(dailyScoreData) {
                LineMark(
                    x: .value("Day", $0.date),
                    y: .value("Attempts", $0.attempt),
                    series: .value("Shot Type", "A")
                )
                .foregroundStyle(by: .value("Total Attempts", "Attempts")) // label
                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .square, dash: [6]))
                .symbol {
                    Circle()
                        .fill(Color.ui.attempt_line)
                        .frame(width: 7)
                }
                
                LineMark(
                    x: .value("Day", $0.date),
                    y: .value("Score", $0.score),
                    series: .value("Shot Type", "B")
                )
                .foregroundStyle(by: .value("Shots Made", "Score")) // label
                .lineStyle(StrokeStyle(lineWidth: 3))
                .symbol {
                    Circle()
                        .fill(Color.ui.secondary)
                        .frame(width: 7)
                }
            }
            // maps to data name
            .chartForegroundStyleScale([
                "Attempts": Color.ui.attempt_line,
                "Score": Color.ui.secondary
            ])
            .chartLegend(position: .top, alignment: .leading, spacing: 20)
            .chartYAxis {
                AxisMarks(position: .leading)
            }
        }
        .padding()
        .border(.black)
    }
}

struct JournalChartView_Previews: PreviewProvider {
    static var previews: some View {
        JournalChartView()
            .frame(width: 335, height: 264)
    }
}
