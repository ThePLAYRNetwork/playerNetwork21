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
import MapKit

struct CreateSessionView: View {
    
    enum SessionField: String, Hashable {
        case sessionName
        case location
        case description
    }
    
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var sessionViewModel: SessionViewModel
    @StateObject var coverImageViewModel = CoverImageViewModel()
    
    @FocusState private var sessionFocusedField: SessionField?
    @State var invalidTitle = false
    @State var invalidLocation = false
    
    
    //   @State var duration: String = ""
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Create Training Session")
                        .font(.system(size: 24))
                        .bold()
                    
                    
                    SessionTextField(
                        text: $sessionViewModel.newSession.title,
                        title: "SESSION NAME",
                        placeholder: "Defense Training",
                        sessionFocusedField: _sessionFocusedField,
                        sessionField: .sessionName,
                        isInvalid: $invalidTitle)
                    
                    
                    HStack {
                        SessionLocationSearchBar(
                            sessionFocusedField: _sessionFocusedField,
                            sessionField: .location,
                            isInvalid: $invalidLocation
                        )
                        
                        .frame(width: geometry.size.width * 0.60)
                        .focused($sessionFocusedField, equals:.location )
                        
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Price".uppercased())
                                .font(.system(size: 12))
                            
                            HStack {
                                
                                TextField(
                                    "$0.00",
                                    text: $sessionViewModel.newSession.price
                                )
                            }
                            .modifier(CreateLabel())
                        }
                    }
                    .zIndex(1)
                    
                    
                    
                    VStack(alignment: .leading, spacing: 3) {
                        
                        
                        
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
                    
                    //                    HStack {
                    //                        VStack(alignment: .leading, spacing: 3) {
                    //                            Text("Date Start".uppercased())
                    //                                .font(.system(size: 12))
                    //
                    //                            HStack {
                    //                                Image("calendar")
                    //                                TextField(
                    //                                    "MM/DD/YY",
                    //                                    text: $dateStart
                    //                                )
                    //                            }
                    //                            .modifier(CreateLabel())
                    //                        }
                    //                        .frame(width: geometry.size.width * 0.33)
                    //
                    //                        VStack(alignment: .leading, spacing: 3) {
                    //                            Text("Date End".uppercased())
                    //                                .font(.system(size: 12))
                    //
                    //                            HStack {
                    //                                Image("calendar")
                    //                                TextField(
                    //                                    "MM/DD/YY",
                    //                                    text: $dateEnd
                    //                                )
                    //                            }
                    //                            .modifier(CreateLabel())
                    //                        }
                    //
                    //                        VStack(alignment: .leading, spacing: 3) {
                    //                            Text("Duration".uppercased())
                    //                                .font(.system(size: 12))
                    //
                    //                            HStack {
                    //                                Image("duration")
                    //                                TextField(
                    //                                    "00.00",
                    //                                    text: $duration
                    //                                )
                    //                            }
                    //                            .modifier(CreateLabel())
                    //                        }
                    //                    }
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Details".uppercased())
                            .font(.system(size: 12))
                        
                        TextField(
                            "List any details important to this session.",
                            text: $sessionViewModel.newSession.details,
                            axis: .vertical
                        )
                        .modifier(CreateLabel())
                    }
                    
                    CoverImageRow()
                    CoverImage()
                    
                    HStack {
                        Spacer()
                        
                                                Button {
                                                    invalidTitle = sessionViewModel.newSession.title.isEmpty
                                                    invalidLocation = sessionViewModel.locationSearchService.selectedCompletion == nil
                        
                                                    // Check for invalid inputs
                                                    if invalidTitle {
                                                        sessionFocusedField = .sessionName
                                                    }
                                                    else if invalidLocation {
                                                        sessionFocusedField = .location
                                                    } else {
                                                        // Valid Input
                                                        Task {
                                                         await
                                                            sessionViewModel.convertAddressToCoordinates()
                                                            navigationModel.path.append(SessionDestination.confirmSession)
                                                        }
                                                   }
                                                } label: {
                                                    Text("Create")
                                                }
                                                .frame(maxWidth: .infinity, alignment: .trailing)
                                                .buttonStyle(CustomButton(color: .red, size: .small))
                        
                        

                        
                        
//                        NavigationLink(destination: ConfirmSessionView()) {
//
//                            Button {
//                                invalidTitle = sessionViewModel.newSession.title.isEmpty
//                                invalidLocation = sessionViewModel.locationSearchService.selectedCompletion == nil
//
//                                // Check for invalid inputs
//                                if invalidTitle {
//                                    print("1")
//                                    sessionFocusedField = .sessionName
//                                }
//                                else if invalidLocation {
//                                    print("2")
//                                    sessionFocusedField = .location
//                                } else {
//                                    // Valid Input
//                                    print("3")
//                                    Task {
//
//                                        await sessionViewModel.convertAddressToCoordinates()
//                                    }
//                                }
//
//                            } label: {
//                                Text("Create")
//                            }
//                        }
//                        .buttonStyle(CustomButton(color: .red, size: .small))
//                        .disabled(isDisabled())
//                        .opacity(isDisabled() ? 0.5 : 1.0)
                    }
                }
            }
            .padding()
        }
        
    }
    
    private func isDisabled() -> Bool {
        return sessionViewModel.newSession.title.isEmpty ||
        //  location.isEmpty ||
        sessionViewModel.newSession.price.isEmpty ||
        //   $dateStart.hashValue ||
        //  dateEnd.isEmpty ||
        sessionViewModel.newSession.details.isEmpty
        
    }
}
//struct CreateSessionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateSessionView()
//
//    }
//}


struct SessionTextField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var image: Image?
    @FocusState var sessionFocusedField: CreateSessionView.SessionField?
    var sessionField: CreateSessionView.SessionField
    @Binding var isInvalid: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(title.uppercased())
                
                if isInvalid {
                    Text("Invalid Input".uppercased())
                        .foregroundColor(.red)
                }
            }
            .font(.system(size: 12, weight: .medium))
            
            HStack {
                image
                
                TextField(
                    placeholder,
                    text: $text
                )
                .focused($sessionFocusedField, equals: sessionField)
                
            }
            .modifier(CreateLabel())
        }
    }
}




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





