//
//  JournalView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 10/21/22.
//

import SwiftUI

struct JournalView: View {
    // state object owns it, observed object just watches the state object?
    @EnvironmentObject var journalViewModel: JournalViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("\(journalViewModel.selectedCourtSection.rawValue)")

                VStack(spacing: 0) {
                    // BackButton()
                    
                    Text("Journal")
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.bottom, 9)
                    
                    TabView {
                        CourtTabItem(isHeatMap: false)
                        CourtTabItem(isHeatMap: true)
                        JournalChartTabItem()
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never)) // .always
                    //                .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .frame(height: 430)
                    //                .border(.green)
                    .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        CustomSegmentedControl(
                            selectedIndex: $journalViewModel.selectedNotes,
                            options: ["Notes", "Drills", "Trends"],
                            spacing: 0
                        )
                        .font(.system(size: 12))
                        .padding(.bottom, 15)
                        
                        // Replace Text
                        if journalViewModel.selectedNotes == 0 {
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                        } else if journalViewModel.selectedNotes == 1 {
                            Text("Showing Drills")
                        } else {
                            Text("Showing Trends")
                        }
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {}) {
                                Image(systemName: "list.bullet")
                            }
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image("camera")
                                    .resizable()
                                    .frame(width: 21, height: 18)
                            }
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image("pencil")
                                    .resizable()
                                    .frame(width: 17.5, height: 18)
                            }
                        }
                        .padding(.top)
                    }
                    .frame(height: 200)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 17)
                            .fill(Color.ui.grayF6F6F6)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .onChange(of: journalViewModel.selectedDate) { newValue in
                // Fetch journal entry for the new date
                print("User changed date \(newValue)")
            }
        }
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
            .environmentObject(JournalViewModel())
    }
}

struct JournalCustomSegmentedControl: View {
    @Binding var selectedIndex: Int
    var options: [String]
    let color = Color.black
    let spacing: CGFloat
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(options.indices, id:\.self) { index in
                let isSelected = selectedIndex == index
                
                Text(options[index])
                    .font(.system(size: 12, weight: .semibold))
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                    .background(Capsule().fill(isSelected ? Color.ui.black : .clear))
                    .foregroundColor(isSelected ? .white : .red)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(
                            response: 0.1, dampingFraction: 1.5, blendDuration: 0.5)) {
                                selectedIndex = index
                            }
                    }
            }
        }
        .background {
            Capsule().fill(Color.ui.grayDADADA)
        }
    }
}
