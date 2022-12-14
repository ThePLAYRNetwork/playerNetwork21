//
//  ClientNotesExpanded.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 12/8/22.
//

import SwiftUI

struct ClientNotesExpanded: View {
    @State var notesEditorText = ""
    
    
    var body: some View {
     
        ZStack(alignment: .bottom) {
                TextEditor(text: $notesEditorText)
                    .frame(height: 213)
                    .colorMultiply(Color.ui.journal_card)
                    .cornerRadius(5)
                
                
                
                
                
                HStack{
                
                    Image("list")
                        .resizable()
                        .frame(width: 18, height: 18)
                    
                    Spacer()
                    Image("camera")
                        .resizable()
                        .frame(width: 18, height: 18)
                    Spacer()
                    
                    Image("pencil")
                        .resizable()
                        .frame(width: 18, height: 18)
             
                }
                .padding(.horizontal)
                .offset(y:-30)
                Spacer()
            }
            .frame(width: 362, height: 191)
            .cornerRadius(10)
    
    }
}

struct ClientNotesExpanded_Previews: PreviewProvider {
    static var previews: some View {
        ClientNotesExpanded()
    }
}
