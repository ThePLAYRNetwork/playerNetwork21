//
//  NoteCell.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/13/22.
//

import SwiftUI

struct NoteCell: View {
    @Binding var note: Note
    
    var body: some View {
        let textParts = note.text.split(whereSeparator: \.isNewline)
        let title = textParts.count >= 1 ? textParts[0] : "No Title"
        let description = textParts.count >= 2 ? textParts[1...].joined() : "No desc"
        
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .fontWeight(.medium)
                .padding(.bottom, 3)
            
            HStack {
                Text(note.createdAt.formatted(date: .numeric, time: .omitted))
                Text(description)
            }
            .lineLimit(1)
            .truncationMode(.tail)
            .padding(.bottom, 20)
            .font(.system(size: 14))
            
            Divider()
        }
        .padding(.top, 20)
    }
}

struct NoteCell_Previews: PreviewProvider {
    static var previews: some View {
        NoteCell(note: .constant(sampleNotes[0]))
    }
}
