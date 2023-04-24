//
//  SearchableDropDownMenu.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 4/5/23.
//

import SwiftUI

struct SearchableDropDownMenu: View {
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    let items: [College]
    
    @State var text = ""
    @State private var isExpanded: Bool = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            LazyVStack(spacing: 0) {
                ForEach(items.filter({ text.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(text) }), id: \.name) { college in
                    Divider()

                    HStack {
                        Text(college.name)
                            .onTapGesture {
                                onboardingViewModel.newUser.school = college.name
                                text = college.name
                                isExpanded = false
                            }
                        
                        Spacer()
                    }
                    .padding(.vertical, 15)
                    .padding(.leading, 7)
                }
            }
        } label: {
            TextField("Select college", text: $text, onEditingChanged: { change in
                if change {
                    isExpanded = true
                    print("Typing")
                } else {
                    print("Done")
                }
            }
            )
            .multilineTextAlignment(.leading)
            .onTapGesture {
                withAnimation {
                    if !isExpanded {
                        isExpanded = true
                        text = ""
                    }
                }
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 9)
        }
        .padding(.horizontal, 7)
        .background(Color.ui.grayF6F6F6)
        .cornerRadius(10)
        .onAppear {
            text = onboardingViewModel.newUser.school
        }
    }
}

struct SearchableDropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        SearchableDropDownMenu(items: College.sampleColleges)
            .environmentObject(OnboardingViewModel(ckUserViewModel: CloudKitUserViewModel(userRepository: UserRepository(), navigationModel: NavigationModel()), userRepository: UserRepository(), navigationModel: NavigationModel()))
            .padding()
    }
}
