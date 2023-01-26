//
//  InputDataView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/8/22.
//

import SwiftUI

struct InputDataView: View {
    @ObservedObject var journalViewModel: JournalViewModel

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
                    
                    Button("Save", action: {})

                }
                .padding(.bottom, 20)
                
                InputDataColumn()
                
                Spacer()
                
            }
            .padding()
            .frame(maxWidth: .infinity)
        .background(Color.ui.black)
        }
    }
}

struct InputDataView_Previews: PreviewProvider {
    static var previews: some View {
        InputDataView(journalViewModel: JournalViewModel())
    }
}
