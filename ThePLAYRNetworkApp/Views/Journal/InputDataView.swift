//
//  InputDataView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/8/22.
//

import SwiftUI
import CloudKit

struct InputDataView: View {
    @EnvironmentObject var journalViewModel: JournalViewModel
    @State var newJournal =  Journal(date: Date())
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button("Cancel", action: {})
                    
                    Spacer()
                    
                    Text("Input Data")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button("Save", action: {
                        Task {
                            await journalViewModel.saveJournalEntry(journal: newJournal)
                        }
                    })
                }
                .padding(.bottom, 20)
                
                InputDataColumn(newJournal: $newJournal)
                
                Spacer()
                
            }
            .padding(19)
            .padding(.top)
            .frame(maxWidth: .infinity)
            .background(Color.ui.court_input_data)
            .onAppear {
                // Fetch journal for current date if it exists
                newJournal = journalViewModel.currentJournal
            }
        }
    }
}

struct InputDataView_Previews: PreviewProvider {
    static var previews: some View {
        InputDataView()
            .environmentObject(JournalViewModel(journalRepository: JournalRepository()))
    }
}
