//
//  PlayerProfileOptions.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 12/20/22.
//https://stackoverflow.com/questions/57735761/how-to-change-selected-segment-color-in-swiftui-segmented-picker

import SwiftUI

struct PlayerProfileOptions: View {

    @State var showOptions: Bool = false
    
    var height = ["4’0\"", "4’1\"","4’2\"","4’3\"","4’4\"","4’5\"","4’6\"","4’7\"","4’8\"","4’9\"","4’10\"","4’11\"","5’0\"",
                  "5’1\"","5’2\"","5’3\"","5’4\"","5’5\"","5’6\"","5’7\"","5’8\"","5’9\"","5’10\"","5’11\"","6’0\"",
                  "6’1\"","6’2\"","6’3\"","6’4\"","6’5\"","6’6\"","6’7\"","6’8\"","6’9\"","6’10\"","6’11\"","7’0\"",
                  "7’1\"","7’2\"","7’3\"","7’4\"","7’5\"","7’6\"","7’7\"","7’8\"","7’9\"","7’10\"","7’11\"","8’0\""]
    @State var selectedHeight = "6’0\""
    

    var weight = 80...360
    @State var selectedWeight = 80
    
    
    
    var age = 8...70
    @State var selectedAge = 18
    
    
    var highestLevel = ["High School", "College", "Professional"]
    @State var selectedHighestLevel = "High School"
    
    var skillLevel = ["Recreation", "Competitive", "Elite"]
    @State var selectedSkill = "Elite"

    
    var school = ["University of California, San Diego"]
    @State var selectedSchool = "University of California, San Diego"
    
    
    
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 246, green: 246, blue: 246, alpha: 1)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.black) ], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.gray)], for: .normal)
    }
    
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                
                VStack(alignment: .leading) {
                    Text("HEIGHT")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.black)
                    
          
                    Menu {
                        Picker(selection: $selectedHeight, label: EmptyView()) {
                            ForEach(height, id: \.self) {
                               // Text($0.description + height2.description)
                                Text($0)
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedHeight.description)
                            Spacer()
                            
                            Image(systemName: showOptions ? "chevron.up" : "chevron.down")
                                .frame(width: 12, height: 6)
                        }
                        
                        .padding()
                        .tint(Color.ui.gray959595)
                        .frame(width: 122, height: 50)
                        .background(Color.ui.grayF6F6F6)
                        .cornerRadius(10)
                    }
                    .onTapGesture {
                        withAnimation{
                            
                            showOptions.toggle()
                        }
                    }
                }
                
                
                
                
                
                
                VStack(alignment: .leading) {
                    Text("WEIGHT")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Menu {
                    Picker("Select", selection: $selectedWeight) {
                        ForEach(weight, id: \.self) {
                            Text($0.description + " lbs")
                        }
                    }
                } label: {
                    HStack {
                        
                        Text(selectedWeight.description)
                        Spacer()
                        
                        Image(systemName: showOptions ? "chevron.up" : "chevron.down")
                            .frame(width: 12, height: 6)
                        //  .offset(y: -4)
                    }
                    
                    .padding()
                    .tint(Color.ui.gray959595)
                    .frame(width: 122, height: 50)
                    .background(Color.ui.grayF6F6F6)
                    .cornerRadius(10)
                }
                .onTapGesture {
                    withAnimation{
                        
                        showOptions.toggle()
                    }
                }
                    
                    
                    
                }
                
                
                VStack(alignment: .leading) {
                    Text("AGE")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.black)
                    Menu {
                    Picker("Select", selection: $selectedAge) {
                        ForEach(age, id: \.self) {
                            Text($0.description)
                        }
                    }
                } label: {
                    HStack {
                        
                        Text(selectedAge.description)
                        Spacer()
                        
                        Image(systemName: showOptions ? "chevron.up" : "chevron.down")
                            .frame(width: 12, height: 6)
                    }
                    
                    .padding()
                    .tint(Color.ui.gray959595)
                    .frame(width: 122, height: 50)
                    .background(Color.ui.grayF6F6F6)
                    .cornerRadius(10)
                }
                .onTapGesture {
                    withAnimation{
                        
                        showOptions.toggle()
                    }
                }
                    
                    
                    
                }
                
            }
            .padding(.bottom)
            
            
            
            
            
            
            
            VStack(alignment: .leading) {
                Text("HIGHEST LEVEL PLAYED")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.bottom, -5)
   
                Picker("Select", selection: $selectedHighestLevel) {
                    ForEach(highestLevel, id: \.self) {
                        
                        Text($0 + "")
                    }
                    
                }
                .foregroundColor(Color.ui.grayF6F6F6)
                .pickerStyle(.segmented)
                .frame(width: 380, height: 50)
                .cornerRadius(10)
                
                
            }
            
            
            
            
            VStack(alignment: .leading) {
                Text("SKILL LEVEl")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.bottom, -5)
                
                
                
                Picker("Select", selection: $selectedSkill) {
                    ForEach(skillLevel, id: \.self) {
                        Text($0)
                    }
                    .foregroundColor(Color.ui.gray959595)
                    
                }
                .pickerStyle(.segmented)
                .frame(width: 380, height: 50)
                .cornerRadius(10)
                
            }
            
            
            VStack(alignment: .leading) {
                Text("SCHOOL")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.black)
                
                
                
                Menu {
                    Picker(selection: $selectedSchool, label: EmptyView()) {
                        ForEach(school, id: \.self) {
                            Text($0)
                        }
                        
                    }
                } label: {
                    HStack {
                        Text(selectedSchool)
                        Spacer()
                        
                        Image(systemName: showOptions ? "chevron.up" : "chevron.down")
                            .frame(width: 12, height: 6)

                    }
                    
                    .padding()
                    .tint(Color.ui.gray959595)
                    .frame(width: 380, height: 50)
                    .background(Color.ui.grayF6F6F6)
                    .cornerRadius(10)
                }
                .onTapGesture {
                    withAnimation{
                        
                        showOptions.toggle()
                    }
                }

                
            }
            
            
        }
    }
}

struct PlayerProfileOptions_Previews: PreviewProvider {
    static var previews: some View {
        PlayerProfileOptions()
    }
}
