//
//  TrainersClassesView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 10/6/22.
//

import SwiftUI

struct TrainersClassesView: View {
    
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    BackButton()
                        .padding(.top)
                    
                    HStack {
                        Image("christopherJones")
                            .resizable()
                            .frame(width: 96, height: 96)
                        
                        
                        
                        VStack(alignment: .leading, spacing: 5) {
                            
                            Text("Christopher Jones")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                            
                            
                            
                            Text("Professional Trainer")
                                .font(.system(size: 16))
                            Text("Strength & Weight Specialist")
                                .font(.system(size: 16))
                            Text("San Diego, CA")
                                .font(.system(size: 16))
                            
                        }
                        
                    }
                    .padding(.top)
                }
                .padding(.leading, 30)
                
                Divider()
                
                
                VStack {
                    CalendarTrainerView(interval: DateInterval(start: .distantPast, end: .distantFuture))
                    //    .padding(.horizontal, 20)
                    
                    
                    
                    
                    
                    HStack {
                        
                        Text("Today")
                            .font(.system(size: 16))
                        
                        Spacer()
                        Text("Mon 11")
                            .font(.system(size: 16))
                        Spacer()
                        Text("Tue 12")
                            .font(.system(size: 16))
                        Spacer()
                        Text("Wed 13")
                            .font(.system(size: 16))
                        
                    }
                    .padding()
                    
                }
                .padding(.horizontal, 20)
                
                
                SessionItemRow()
                    .padding(.horizontal, 10)
                
                
                
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

//struct TrainersClassesView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrainersClassesView()
//    }
//}
