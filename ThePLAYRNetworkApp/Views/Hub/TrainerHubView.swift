//
//  TrainerHubView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/1/22.
//

import SwiftUI

struct TrainerHubView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AtAGlanceView()
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color("veryLight_gray"))
                    .frame(height: 300)
                    .padding()
                    .overlay(
                    HubChartView()
                        .frame(height: 290)
                        .padding()
                    )
                
                
                HStack {
                    RoundedRectangle(cornerRadius: 4)
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 89, height: 89)
                        .overlay(
                            Image("cross.square")
                                .resizable()
                                .frame(width: 46.94, height: 47.18)
                                .padding(.top, 10)
                        )
                    
                    
                    RoundedRectangle(cornerRadius: 4)
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 89, height: 89)
                        .overlay(
                            Image("chart")
                                .resizable()
                                .frame(width: 46.94, height: 47.18)
                                .padding(.top, 10)
                        )
                    
                    
                    
                    
                    
                    RoundedRectangle(cornerRadius: 4)
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 89, height: 89)
                        .overlay(
                            Image("personSearch")
                                .resizable()
                                .frame(width: 46.94, height: 47.18)
                                .padding(.top, 10)
                        )
                    
                    
                    RoundedRectangle(cornerRadius: 4)
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 89, height: 89)
                        .overlay(
                            Image("book")
                                .resizable()
                                .frame(width: 46.94, height: 47.18)
                                .padding(.top, 10)
                        )
                    
                }
                .padding()
                .foregroundColor(Color("red"))
                
                
                
                //  VStack {
                
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color("veryLight_gray"))
                    .frame(maxWidth: .infinity, minHeight: 450)
                    .padding()
                    .overlay(
                        VStack(alignment: .leading) {
                            Text("Current Bookings")
                                .font(.system(size: 20, weight: .semibold))
                                .padding(.leading, 23)
                                .foregroundColor(.black)
                            
                            CalendarTrainerView(interval: DateInterval(start: .distantPast, end: .distantFuture))
                                .padding()
                                .frame(height: 370)
                            
                        }
                            .frame(height: 350)
                    )
            }
        }
    }
}

struct TrainerHubView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerHubView()
        // AtAGlanceView()
        
        
    }
}







struct AtAGlanceView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("AT A GLANCE..")
                .foregroundColor(.white)
                .font(.system(size: 12))
            
            HStack {
                VStack(alignment: .leading) {
                    Text("2")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                    Text("Active Sessions")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                }
                
                Divider()
                    .overlay(.white)
                    .frame(width: 15, height: 40)
                    .padding(.horizontal, 20)
                
                
                VStack(alignment: .leading) {
                    
                    HStack(alignment: .bottom) {
                        Text("10")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        Text("+5%")
                            .font(.system(size: 12))
                            .foregroundColor(.green)
                            .padding(.leading, -5)
                        Image("arrow")
                            .resizable()
                            .frame(width: 16, height: 10)
                            .padding(.leading, -7)
                    }
                    
                    
                    Text("Current Bookings")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                    
                    
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.black)
        .cornerRadius(10)
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
}
