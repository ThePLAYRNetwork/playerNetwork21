//
//  ConfirmSessionView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 4/11/23.
//

import SwiftUI

struct ConfirmSessionView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var sessionViewModel: SessionViewModel
    
    
    @State var details: String = ""
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Group {
                    Text("Confirm Training Session")
                        .font(.system(size: 24))
                        .bold()
                    
                    CoverImage()
                        .padding(.vertical, 3)
                    
                    VStack(alignment: .leading,spacing: -5) {
                        
                    Text("Defense Training")
                        .font(.system(size: 24))
                        .bold()
                 
                    
                    HStack {
                        Text("August 1- 31, 2022")
                            .font(.system(size: 16))
                        Text(".")
                            .font(.title)
                            .bold()
                            .offset(y: -7)
                        
                        Text("1 hr")
                            .font(.system(size: 16))
                        
                        Text(".")
                            .font(.title)
                            .bold()
                            .offset(y: -7)
                        
                        Text("$50")
                            .font(.system(size: 16))
                        
                    }
                    .foregroundColor(.black)
                    
                    Text("Gym Name, San Diego")
                            .font(.system(size: 16))
                        .padding(.bottom)
              }

                    
                    VStack(alignment: .leading,spacing: 2) {
                        
                        Text("Training Details")
                            .bold()
                            .font(.system(size: 20))
                        TextField(
                            "List any details important to this session.",
                            text: $details,
                            axis: .vertical
                        )
                        .modifier(CreateLabel())
                    }
                    .padding(.bottom)
                    
                    
                    VStack(alignment: .leading,spacing: 4) {
                        
                    Text("Session Availability")
                        .font(.system(size: 20))
                        .bold()
                    //    .padding(.top)
                    //    .padding(.bottom)
                    
               
                        
                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 40)
                            .overlay {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Tuesday")
                                            .foregroundColor(.black)
                                            .font(.system(size:14))
                                            .bold()
                                        Text("Repeats every week")
                                            .foregroundColor(Color.ui.gray959595)
                                            .font(.system(size: 10))
                                        Spacer()
                                        
                                    }
                                    
                                    
                                    HStack {
                                        Text("10:00am - 11:00am")
                                            .foregroundColor(Color.ui.blue)
                                            .font(.system(size: 12))
                                        Spacer()
                                        
                                    }
                                }
                                .padding([.vertical, .leading])
                                
                            }
                            .foregroundColor(Color.ui.grayF6F6F6)
                        
                        
                        
                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 40)
                            .overlay {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Wednesday")
                                            .foregroundColor(.black)
                                            .font(.system(size:14))
                                            .bold()
                                        Text("Repeats bi-weekly, starting October 3")
                                            .foregroundColor(Color.ui.gray959595)
                                            .font(.system(size: 10))
                                        Spacer()
                                        
                                    }
                                    
                                    
                                    HStack {
                                        Text("10:00am - 11:00am")
                                            .foregroundColor(Color.ui.blue)
                                            .font(.system(size: 12))
                                        Spacer()
                                        
                                    }
                                }
                                .padding([.vertical, .leading])
                                
                            }
                            .foregroundColor(Color.ui.grayF6F6F6)
                    }
                    .padding(.bottom)
                }

                
            }
            
            
            NavigationStack(path: $navigationModel.path) {
                CreateSessionView()
                    .navigationDestination(for: SessionDestination.self) { destination in
                        switch destination {
                        case .confirmSession:
                            ConfirmSessionView()
                        }
                    }
            }
            
            
            
            
            ConfirmSessionButtons(buttonTitle: "Confirm", session: sessionViewModel.newSession)
                
  //                            .disabled(isDisabled())
  //                            .opacity(isDisabled() ? 0.5 : 1.0)
  //
    //                  }
            
        }
        .padding()
        
    }
}

struct ConfirmSessionView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmSessionView()
    }
}
