//
//  NewNoteView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/13/22.
//

import SwiftUI

struct NewNoteView: View {
    @Binding var note: Note
    
    var body: some View {
        let textParts = note.text.split(whereSeparator: \.isNewline)
        let title = textParts.count >= 1 ? textParts[0] : "No Title"
        let description = textParts.count >= 2 ? textParts[1...].joined() : "No desc"
        
        VStack {
            Text(note.createdAt.formatted(date: .abbreviated, time: .shortened))
                .font(.system(size: 12))
                .foregroundColor(Color.ui.gray959595)
            
            TextEditor(text: $note.text)

            Spacer()
            
            HStack {
                Button(action: {}) {
                    Image(systemName: "list.bullet")
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image("camera")
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image("pencil")
                }
            }
        }
        .padding()
    }
}

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView(note: .constant(sampleNotes[0]))
    }
}
