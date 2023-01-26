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
    @State var sessionName: String = ""
    @State var location: String = ""
    @State var price: String = ""
    @State var dateStart: String = ""
    @State var dateEnd: String = ""
    @State var duration: String = ""
    @State var details: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                Text("Create Training")
                    .font(.system(size: 24))
                    .bold()
                
                VStack(alignment: .leading, spacing: 3) {
                    Text("Session Name".uppercased())
                        .font(.system(size: 12))
                    
                    TextField(
                        "Training",
                        text: $sessionName
                    )
                    .modifier(CreateLabel())
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Location".uppercased())
                            .font(.system(size: 12))
                        
                        HStack {
                            Image("location")
                            TextField(
                                "Ex. Courts",
                                text: $location
                            )
                        }
                        .modifier(CreateLabel())
                    }
                    .frame(width: geometry.size.width * 0.60)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Price".uppercased())
                            .font(.system(size: 12))
                        
                        HStack {
                            Image("location")
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
                
                Button("Create", action: {})
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
        }
    }
}

struct CreateSessionView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSessionView()
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
