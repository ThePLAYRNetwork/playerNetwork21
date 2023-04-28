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
    @State var newJournal =  Journal(userID: CKRecord.Reference(record: CKRecord(recordType: "Journal"), action: .none), date: Date())
    
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
                        print("Saving new journal entry into cloudkit")
                        journalViewModel.currentJournal = newJournal
                    })
                }
                .padding(.bottom, 20)
                
                InputDataColumn(newJournal: $newJournal)
                
                Spacer()
                
            }
            .padding(.top, 25)
            .padding(19)
            .frame(maxWidth: .infinity)
            .background(Color.ui.black)
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
            .environmentObject(JournalViewModel())
    }
}
