//
//  CreateSessionView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/15/22.
//

// CalendarTrainerView has to be in scrollview
// CalendarView
// horzontal padding?

import SwiftUI

struct CreateSessionView: View {
    @EnvironmentObject var sessionViewModel: SessionViewModel
    @StateObject var coverImageViewModel = CoverImageViewModel()
    
    
    
    
    @State var sessionName: String = ""
    @State var location: String = ""
    @State var price: String = ""
    @State var dateStart: String = ""
    @State var dateEnd: String = ""
    @State var duration: String = ""
    @State var details: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Create Training Session")
                        .font(.system(size: 24))
                        .bold()
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Session Name".uppercased())
                            .font(.system(size: 12))
                        
                        TextField(
                            "Session",
                            text: $sessionName
                        )
                        .modifier(CreateLabel())
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            HStack {
                                GameTextField(
                                    text: $sessionViewModel.newSession.location,
                                    title: "Location",
                                    placeholder: "Ex. Courts",
                                    image: Image("location")
                                )
                                
                            }
                            .frame(width: geometry.size.width * 0.60)
                        }
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Price".uppercased())
                                .font(.system(size: 12))
                            
                            HStack {
                                
                                TextField(
                                    "$0.00",
                                    text: $price
                                )
                            }
                            .modifier(CreateLabel())
                        }
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Date Start".uppercased())
                                .font(.system(size: 12))
                            
                            HStack {
                                Image("calendar")
                                TextField(
                                    "MM/DD/YY",
                                    text: $dateStart
                                )
                            }
                            .modifier(CreateLabel())
                        }
                        .frame(width: geometry.size.width * 0.33)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Date End".uppercased())
                                .font(.system(size: 12))
                            
                            HStack {
                                Image("calendar")
                                TextField(
                                    "MM/DD/YY",
                                    text: $dateEnd
                                )
                            }
                            .modifier(CreateLabel())
                        }
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Duration".uppercased())
                                .font(.system(size: 12))
                            
                            HStack {
                                Image("duration")
                                TextField(
                                    "00.00",
                                    text: $duration
                                )
                            }
                            .modifier(CreateLabel())
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Details".uppercased())
                            .font(.system(size: 12))
                        
                        TextField(
                            "List any details important to this session.",
                            text: $details,
                            axis: .vertical
                        )
                        .modifier(CreateLabel())
                    }
                    
                    CoverImageRow()
                    
                    VStack(alignment: .leading, spacing: 3) {
                        CoverImage()
                        
                            .padding(.vertical)
                    
                        Text("Session Availability".uppercased())
                            .font(.system(size: 12))
                        
                        NavigationLink {
                            SelectDayView()
                        } label: {
                            HStack {
                                Text("Select Days")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.ui.grayF6F6F6)
                            }
                        }
                    }
                    
                    Spacer()
                
                }
 
                HStack {
                    Spacer()
                    NavigationLink(destination: ConfirmSessionView()) {
                        Text("Create")
                    }
                    .buttonStyle(CustomButton(color: .red, size: .small))
                    .disabled(isDisabled())
                    .opacity(isDisabled() ? 0.5 : 1.0)
                }
            }
            .padding()
        }
    }
    
    
    
    private func isDisabled() -> Bool {
        return sessionName.isEmpty ||
      //  location.isEmpty ||
        price.isEmpty ||
        dateStart.isEmpty ||
        dateEnd.isEmpty ||
        details.isEmpty
        
    }
}

//struct CreateSessionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateSessionView()
//
//    }
//}



struct CreateLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.ui.gray959595)
            .disableAutocorrection(true)
            .padding(.vertical, 6)
            .padding(.horizontal, 9)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.ui.grayF6F6F6)
            }
    }
}



struct ConfirmSessionButtons: View {
    
    @EnvironmentObject var sessionViewModel: SessionViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var navigationModel: NavigationModel
    
    @State var buttonTitle: String
    
    
    let session: Session
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                Task {
                    await sessionViewModel.createSession()
                }
            } label: {
                Text(buttonTitle)
            }
            .buttonStyle(CustomButton(color: .red, size: .small))
        }
    }
}





