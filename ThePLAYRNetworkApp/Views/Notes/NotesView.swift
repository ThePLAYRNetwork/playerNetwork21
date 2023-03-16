//
//  NotesView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/13/22.
//

import SwiftUI

struct NotesView: View {
    @State var text = ""
    @State var notes = Note.sampleNotes
    @State var newNote = Note.sampleNotes[0]
    
    var body: some View {
        VStack {
            HStack {
                SearchBar(text: $text)
                
                NavigationLink {
                    NewNoteView(note: $newNote)
                        .onDisappear {
                            print("On Disappear")
//                            if newNote.text != "" {
//                                notes.append(newNote)
//                            }
//                            newNote = Note(text: "", createdAt: Date())
                        }
                } label: {
                    Image("edit")
                        .resizable()
                        .frame(width: 25, height: 25)
                }

            }
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    ForEach($notes, id: \.recordName) { $note in
                        NavigationLink {
                            NewNoteView(note: $note)
                        } label: {
                            NoteCell(note: $note)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            
        }
        .padding()
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
