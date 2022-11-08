//
//  HubChartView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/2/22.
//

import SwiftUI
import Charts


struct DailyEarnings: Identifiable {
    var id = UUID() // use cloudkit id in future.
    var category: String
    var projected: Int
    var current: Int
    var date: Date

    init(category: String, projected: Int, current: Int, year: Int, month: Int, day: Int) {
        let calendar = Calendar.autoupdatingCurrent
        self.category = category
        self.projected = projected
        self.current = current
        self.date = calendar.date(from: DateComponents(year: year, month: month, day: day))!
    }
}


var data: [DailyEarnings] = [
    DailyEarnings(category: "Earnings", projected: 230, current: 100, year: 2023, month: 10, day: 4),
    DailyEarnings(category: "Earnings", projected: 150, current: 300, year: 2023, month: 10, day: 5),
    DailyEarnings(category: "Earnings", projected: 280, current: 100, year: 2023, month: 10, day: 6),
    DailyEarnings(category: "Earnings", projected: 140, current: 200, year: 2023, month: 10, day: 7),
    DailyEarnings(category: "Earnings", projected: 190, current: 250, year: 2023, month: 10, day: 8),
    DailyEarnings(category: "Earnings", projected: 100, current: 180, year: 2023, month: 10, day: 9),
    DailyEarnings(category: "Earnings", projected: 280, current: 260, year: 2023, month: 10, day: 10)
]



// series used for disguinshing between lines. First part is just a description, second part is the distinguishable
struct HubChartView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Earnings")
                .font(.system(size: 16, weight: .medium))
            Text("Jul 11 - 17,2022")
                .font(.system(size: 16, weight: .medium))
            Chart(data) {
                LineMark(
                    x: .value("Day", $0.date),
                    y: .value("Current", $0.current),
                    series: .value("Shot Type", "A")
                )
                .foregroundStyle(by: .value("Total Current", "Current")) // label
                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .square, dash: [6]))
                .symbol {
                    Circle()
                        .fill(Color("subheading_text"))
                        .frame(width: 7)
                }

                LineMark(
                    x: .value("Day", $0.date),
                    y: .value("Projected", $0.projected),
                    series: .value("Shot Type", "B")
                )
                .foregroundStyle(by: .value("Shots Made", "Projected")) // label
                .lineStyle(StrokeStyle(lineWidth: 3))
                .symbol {
                    Circle()
                        .fill(Color("purple"))
                        .frame(width: 7)
                }
            }
            // maps to data name
            .chartForegroundStyleScale([
                "Current": Color("subheading_text"),
                "Projected": Color("purple")
            ])
            .chartLegend(position: .top, alignment: .leading, spacing: 20)
            .chartYAxis {
                AxisMarks(position: .leading)
            }
        }
        .padding()
       
    }
}

struct HubChartView_Previews: PreviewProvider {
    static var previews: some View {
        HubChartView()
            .frame(width: 335, height: 264)
    }
}



