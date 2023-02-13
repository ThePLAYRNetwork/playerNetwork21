//
//  TrainersView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 10/3/22.
//

import SwiftUI

struct TrainersView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                TrainerProfile()
                
                HStack {
                    HStack(spacing: -4) {
                        ForEach(0..<3) { i in
                            
                            Circle()
                                .frame(width: 33, height: 33)
                                .foregroundColor(Color.ui.grayD9D9D9)
                                .overlay {
                                    Circle().stroke(.white)
                                }
                        }
                        
                    }
                    .padding(.trailing,5)
                    
                    
                    
                    Text("**Michael, Charles,** and **4 others** have trained with Christopher")
                        .font(.system(size: 12))
                    
                }
                
                
                
                HStack {
                    Button {
                        
                    } label: {
                        Text("Connect")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(width: 131, height: 33)
                            .background(Color.ui.accentColor)
                            .background(in: RoundedRectangle(cornerRadius: 5))
                        
                    }
                    
                    
                    
                    
                    Button {
                        
                    } label: {
                        Text("Message")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(width: 131, height: 33)
                            .background(.black)
                            .background(in: RoundedRectangle(cornerRadius: 5))
                        
                    }
                    
                    
                    
                    Button {
                        
                    } label: {
                        HStack(spacing: 3){
                            ForEach(0..<3) { i in
                                Circle()
                                    .frame(width: 2, height: 2)
                                    .foregroundColor(.white)
                                
                            }
                        }
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .frame(width: 57, height: 33)
                        .background(.black)
                        .background(in: RoundedRectangle(cornerRadius: 5))
                    }
                    
                }
                .padding(.top, 5)
                
                
            }
            .padding()
            
            Divider()
            
            HighlightedClasses()
              .padding(.horizontal, 5)
            
        }

    }
}

struct TrainersView_Previews: PreviewProvider {
    static var previews: some View {
        TrainersView()
    }
}
