//
//  SelectDayView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/27/22.
//

import SwiftUI

struct SelectDayView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var date = Date()
    @State var trainingSessionCollection: TrainingSessionCollection = TrainingSessionCollection.sampleSession
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .bold()
                    }
                    .buttonStyle(.plain)
                    
                    Text("Session Availability")
                        .fontWeight(.bold)
                }
                .font(.system(size: 24))
                .padding(.leading, 24)
                .padding(.bottom, 20)
                .padding(.top)
                
                Text("Select Days".uppercased())
                    .font(.system(size: 12))
                    .foregroundColor(Color.ui.gray959595)
                    .fontWeight(.bold)
                    .padding(.leading, 24) // line up with calendar
                
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .padding([.horizontal])
                
                ForEach(trainingSessionCollection.data) { session in
                    // show only active sessions
                    if session.times.count > 0 {
                        SelectDayCard(session: session)
                            .padding(.horizontal)
                            .padding(.bottom, 5)
                    }
                }
                .padding(.bottom, 15)
                
                divider
                
                VStack {
                    Text("Weekly".uppercased())
                        .font(.system(size: 12))
                        .foregroundColor(Color.ui.gray959595)
                        .fontWeight(.bold)
                        .padding(.leading, 24) // line up with calendar
                }
                .padding(.top, 25)
                
                ForEach($trainingSessionCollection.data) { $session in
                    SelectDayCell(session: $session)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button("Save", action: {})
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding([.top, .trailing])
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct SelectDayView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDayView()
    }
}



// Diviers are slightly different for other views
extension SelectDayView {
    private var divider: some View {
        Rectangle()
            .frame(height: 4)
            .foregroundColor(Color.ui.grayECECEC)
    }
}
