//
//  NotesView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/13/22.
//

import SwiftUI


let sampleNotes: [Note] = [
    Note(text: "Title of note \n Short preview of the notes contents. Some more text for debugging.", createdAt: Date()),
    Note(text: "Session Ideas \n Try to advertise on ig", createdAt: Date()),
    Note(text: "Drills \n Warm up:", createdAt: Date()),
    Note(text: "TONY improvements \n Be more aware of court", createdAt: Date())
]

struct NotesView: View {
    @State var text = ""
    @State var notes = sampleNotes
    @State var newNote = Note(text: "", createdAt: Date())
    
    var body: some View {
        VStack {
            HStack {
                SearchBar(text: $text)
                
                NavigationLink {
                    NewNoteView(note: $newNote)
                        .onDisappear {
                            print("On Disappear")
                            if newNote.text != "" {
                                notes.append(newNote)
                            }
                            newNote = Note(text: "", createdAt: Date())
                        }
                } label: {
                    Image("edit")
                        .resizable()
                        .frame(width: 25, height: 25)
                }

            }
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    ForEach($notes) { $note in
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
