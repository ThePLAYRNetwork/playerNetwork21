//
//  DefenseTrainingItemView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/15/22.
//

import SwiftUI

struct DefenseTrainingItemView: View {
    @State private var showingAlert = false
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text("Defense Training")
                .font(.system(size: 16, weight: .semibold))
            VStack(alignment: .leading,spacing: -5){
                HStack {
                    Text("Tuesday, August 2")
                    
                    Text(".")
                        .font(.title)
                        .bold()
                        .offset(y: -7)
                    
                    Text("10:00am - 11:00am")
                }
                .foregroundColor(Color.ui.gray959595)
                
                HStack {
                    Text("Booked by")
                        .foregroundColor(Color.ui.gray959595)
                    
                    
                    Text("Alex Allens")
                        .foregroundColor(.black)
                    
                }
                
            }
            HStack{
                Spacer()
                NavigationLink(destination: ActiveSessionsView()) {
                    Text("More Details")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(width: 126, height: 33)
                        .background(.black)
                        .background(in: RoundedRectangle(cornerRadius: 10))
                }
                

                Button {
                    showingAlert = true
                } label: {
                    Text("Cancel Session")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(width: 148, height: 33)
                        .background(Color.ui.accentColor)
                        .background(in: RoundedRectangle(cornerRadius: 10))
                    
                }

                
            }
//            .padding(.horizontal)
//            .padding()
            
            Divider()
        }
        .padding()
    }
}

struct DefenseTrainingItemView_Previews: PreviewProvider {
    static var previews: some View {
        DefenseTrainingItemView()
    }
}
