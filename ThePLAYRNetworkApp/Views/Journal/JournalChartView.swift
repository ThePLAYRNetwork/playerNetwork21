//
//  JournalChartView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/1/22.
//

import SwiftUI
import Charts

struct JournalChartEntry: Identifiable {
    var id = UUID() // use cloudkit id in future.
    var score: Int
    var attempt: Int
    var date: Date
    
//    init(category: String, score: Int, attempt: Int, year: Int, month: Int, day: Int) {
//        let calendar = Calendar.autoupdatingCurrent
//        self.section = category
//        self.score = score
//        self.attempt = attempt
//        self.date = calendar.date(from: DateComponents(year: year, month: month, day: day))!
//    }
    
    init(score: Int, attempt: Int, date: Date) {
        self.score = score
        self.attempt = attempt
        self.date = date
    }
}

//var dailyScoreData: [JournalChartEntry] = [
//    JournalChartEntry(category: "Right Corner", score: 5, attempt: 6, year: 2023, month: 10, day: 4),
//    JournalChartEntry(category: "Right Corner", score: 5, attempt: 7, year: 2023, month: 10, day: 5),
//    JournalChartEntry(category: "Right Corner", score: 6, attempt: 6, year: 2023, month: 10, day: 6),
//    JournalChartEntry(category: "Right Corner", score: 5, attempt: 7, year: 2023, month: 10, day: 7),
//    JournalChartEntry(category: "Right Corner", score: 8, attempt: 8, year: 2023, month: 10, day: 8),
//    JournalChartEntry(category: "Right Corner", score: 10, attempt: 10, year: 2023, month: 10, day: 9),
//    JournalChartEntry(category: "Right Corner", score: 8, attempt: 10, year: 2023, month: 10, day: 10)
//]

// series used for disguinshing between lines. First part is just a description, second part is the distinguishable
struct JournalChartView: View {
    @EnvironmentObject var journalViewModel: JournalViewModel
    
    var data: [JournalChartEntry] {
        switch journalViewModel.selectedCourtSection {
        case .leftCorner:
            return journalViewModel.journalData.map { JournalChartEntry(score: $0.leftCornerScore, attempt: $0.leftCornerAttempt, date: $0.date) }
                .sorted(by: { $0.date < $1.date})
        case .leftShortCorner:
            return journalViewModel.journalData.map { JournalChartEntry(score: $0.leftShortCornerScore, attempt: $0.leftShortCornerAttempt, date: $0.date) }
                .sorted(by: { $0.date < $1.date})
        case .paint:
            return journalViewModel.journalData.map { JournalChartEntry(score: $0.paintScore, attempt: $0.paintAttempt, date: $0.date) }
                .sorted(by: { $0.date < $1.date})
        case .rightShortCorner:
            return journalViewModel.journalData.map { JournalChartEntry(score: $0.rightShortCornerScore, attempt: $0.rightShortCornerAttempt, date: $0.date) }
                .sorted(by: { $0.date < $1.date})
        case .rightCorner:
            return journalViewModel.journalData.map { JournalChartEntry(score: $0.rightCornerScore, attempt: $0.rightCornerAttempt, date: $0.date) }
                .sorted(by: { $0.date < $1.date})
        case .middleMidRange:
            return journalViewModel.journalData.map { JournalChartEntry(score: $0.middleMidRangeScore, attempt: $0.middleMidRangeAttempt, date: $0.date) }
                .sorted(by: { $0.date < $1.date})
        case .leftMidRange:
            return journalViewModel.journalData.map { JournalChartEntry(score: $0.leftMidRangeScore, attempt: $0.leftMidRangeAttempt, date: $0.date) }
                .sorted(by: { $0.date < $1.date})
        case .freeThrow:
            return journalViewModel.journalData.map { JournalChartEntry(score: $0.freeThrowScore, attempt: $0.freeThrowAttempt, date: $0.date) }
                .sorted(by: { $0.date < $1.date})
        case .rightMidRange:
            return journalViewModel.journalData.map { JournalChartEntry(score: $0.rightMidRangeScore, attempt: $0.rightMidRangeAttempt, date: $0.date) }
                .sorted(by: { $0.date < $1.date})
        case .leftWing:
            return journalViewModel.journalData.map { JournalChartEntry(score: $0.leftWingScore, attempt: $0.leftWingAttempt, date: $0.date) }
                .sorted(by: { $0.date < $1.date})
        case .leftShot:
            return journalViewModel.journalData.map { JournalChartEntry(score: $0.leftShotScore, attempt: $0.leftShotAttempt, date: $0.date) }
                .sorted(by: { $0.date < $1.date})
        case .topOfTheKey:
            return journalViewModel.journalData.map { JournalChartEntry(score: $0.topOfTheKeyScore, attempt: $0.topOfTheKeyAttempt, date: $0.date) }
                .sorted(by: { $0.date < $1.date})
        case .rightShot:
            return journalViewModel.journalData.map { JournalChartEntry(score: $0.rightShotScore, attempt: $0.rightShotAttempt, date: $0.date) }
                .sorted(by: { $0.date < $1.date})
        case .rightWing:
            return journalViewModel.journalData.map { JournalChartEntry(score: $0.rightWingScore, attempt: $0.rightWingAttempt, date: $0.date) }
                .sorted(by: { $0.date < $1.date})
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text(journalViewModel.selectedCourtSection.rawValue)
                .font(.system(size: 16, weight: .medium))
                .padding(.bottom, 3)
            
            VStack(alignment: .leading) {
                HStack {
                    Image("attempts_legend_icon")
                        .resizable()
                        .frame(width: 22, height: 2)
                    
                    Text("Attempts")
                }
                
                HStack {
                    Image("score_legend_icon")
                        .resizable()
                        .frame(width: 22, height: 2)
                    
                    Text("Scores")
                }
            }
            .font(.system(size: 8))
            .padding(.bottom)
            
            Chart(data) {
                LineMark(
                    x: .value("Day", $0.date),
                    y: .value("Attempts", $0.attempt),
                    series: .value("Shot Type", "A")
                )
                .foregroundStyle(by: .value("Total Attempts", "Attempts")) // label
                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .square, dash: [6]))
                .symbol {
                    Circle()
                        .fill(Color.ui.gray959595)
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
                        .fill(Color.ui.accent)
                        .frame(width: 7)
                }
            }
            // maps to data name
            .chartForegroundStyleScale([
                "Attempts": Color.ui.gray959595,
                "Score": Color.ui.accent
            ])
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartLegend(.hidden)
        }
        .padding()
        .frame(height: 275)
        .border(.black)
        .background(.white)

    }
}

struct JournalChartView_Previews: PreviewProvider {
    static var previews: some View {
        JournalChartView()
            .frame(width: 335, height: 264)
            .environmentObject(JournalViewModel(journalRepository: JournalRepository()))
    }
}
