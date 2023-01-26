//
//  ActiveSessionItemView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/18/22.
//

import SwiftUI

struct ActiveSessionItemView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
           
                Text("Back to Basics")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.bottom, -20)
            VStack(alignment: .leading, spacing: -8) {
                
                HStack {
                    Text("MTuW")
                        .font(.system(size: 12))
                    Text(".")
                        .font(.title)
                        .bold()
                        .offset(y: -7)
                    Text("$50")
                        .font(.system(size: 12))
                    Text(".")
                        .font(.title)
                        .bold()
                        .offset(y: -7)
                    Text("1 hour")
                        .font(.system(size: 12))
                    
                }
                
                
                Text("Gym Name")
                    .font(.system(size: 12))
                
            }
            
            HStack {
                VStack(alignment: .trailing){
                    HStack(alignment: .bottom) {
                        Text("50")
                            .font(.system(size: 32, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text("+2%")
                            .font(.system(size: 12))
                            .foregroundColor(.green)
                            .padding(.leading, -5)
                        Image("arrowUp")
                            .resizable()
                            .frame(width: 16, height: 10)
                            .padding(.leading, -7)
                    }
                    
                    Text("Views")
                        .font(.system(size: 14))
                }
                
                Spacer()
                VStack(alignment: .trailing) {
                    HStack(alignment: .bottom) {
                        
                        Text("8")
                            .font(.system(size: 32, weight: .semibold))
                            .foregroundColor(.black)
                        Text("-9%")
                            .font(.system(size: 12))
                            .foregroundColor(Color.ui.primary)
                            .padding(.leading, -5)
                        Image("arrowDown")
                            .resizable()
                            .frame(width: 16, height: 10)
                            .padding(.leading, -7)
                    }
                    Text("Sign Ups")
                        .font(.system(size: 14))
                }
                
                Spacer()
                VStack(alignment: .trailing) {
                    HStack(alignment: .bottom) {
                        Text("7")
                            .font(.system(size: 32, weight: .semibold))
                            .foregroundColor(.black)
                        Text("-3%")
                            .font(.system(size: 12))
                            .foregroundColor(Color.ui.primary)
                            .padding(.leading, -5)
                        Image("arrowDown")
                            .resizable()
                            .frame(width: 16, height: 10)
                            .padding(.leading, -7)
                    }
                    Text("Shares")
                        .font(.system(size: 14))
                }
                
            }
            .padding(.horizontal)
            
    //        Spacer()
            
            
            HStack {
                Spacer()
                Button {
                 
                } label: {
                    Text("Edit")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(width: 60, height: 33)
                        .background(Color.ui.primary)
                        .background(in: RoundedRectangle(cornerRadius: 10))
                    
                }
                
                Button {
                   
                } label: {
                    Text("View Full Analytics")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(width: 174, height: 33)
                        .background(Color.ui.primary)
                        .background(in: RoundedRectangle(cornerRadius: 10))
                    
                }
            }
            
            
            
            
        }
        .padding(.vertical)
        .padding(.all, 5)
        .frame(maxWidth: .infinity ,maxHeight: 211)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.ui.grayF6F6F6)
                .shadow(color: Color.ui.grayD9D9D9, radius: 1, x: 0, y: 5) 
        )
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

struct ActiveSessionItemView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveSessionItemView()
    }
}
