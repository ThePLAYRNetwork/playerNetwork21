//
//  CancelTraining.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/16/22.
//

import SwiftUI

struct CancelTraining: View {
    @State var textEditorText = ""
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
        
            ScrollView{
                
                VStack(alignment: .leading) {
                    Text("Cancel Session")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .padding(.leading, 17)
                        .padding(.top, 5)
                    
                    Text("Defense Training")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.bottom, -5)
                    
                    VStack(alignment: .leading, spacing: -5){
                        
                        Text("Tuesday August 2, 2022")
                        
                        HStack {
                            Text("10:00am - 11:00am")
                            Text(".")
                                .font(.title)
                                .bold()
                                .offset(y: -7)
                            
                            Text("$50")
                        }
                        
                        Text("Gym Name, San Diego")
                        
                    }
                    .padding(.top, -2)
                    .padding(.bottom, 10)
                    
                    
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 4)
                    
                    
                    HStack{
                        Text("Booked by")
                            .foregroundColor(Color.ui.subheading_text)
                        Text("Alex Allens")
                            .foregroundColor(.black)
                    }
                    .padding(.vertical)
                    
                    
                    
                }
                .padding(.horizontal)
                Divider()
                
                
                VStack(alignment: .leading){
                    
                    Text("Let Alex know why the session is canceled")
                        .fontWeight(.semibold)
                    
                    TextEditor(text: $textEditorText)
                        .frame(height: 213)
                        .colorMultiply(Color.ui.journal_card)
                        .cornerRadius(5)

                    Spacer()
                }
                .padding()
                
            }
            
            
            HStack{
                Spacer()
                Button {
                    
                } label: {
                    
                    Text("Back")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 50, height: 33)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1.0)
                        )
                }

                Button {
                    
                } label: {
                    Text("Cancel Session")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(width: 131, height: 33)
                        .background(Color.ui.primary)
                        .background(in: RoundedRectangle(cornerRadius: 10))
                    
                }
                
            }
            .padding(.horizontal)
            .padding()
            .background(.white)
            
            
            
        }
    }
}

struct CancelTraining_Previews: PreviewProvider {
    static var previews: some View {
        CancelTraining()
    }
}
