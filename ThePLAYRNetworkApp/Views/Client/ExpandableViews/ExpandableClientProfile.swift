//
//  ExpandableClientProfile.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 12/7/22.
//

import SwiftUI

struct ExpandableClientProfile: View {
    
    @State var isPaymentExpanding: Bool = false
    @State var isBookedExpanding: Bool = false
    @State var isHistoryExpanding: Bool = false
    @State var isNotesExpanding: Bool = false
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            //Outstanding Payments
            VStack(alignment: .leading) {
                HStack{
                    Text("Outstanding Payments")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                        withAnimation {
                            isPaymentExpanding.toggle()
                        }
                    } label: {
                        Image(systemName: isPaymentExpanding ? "chevron.up" : "chevron.down")
                            .foregroundColor(.black)
                            .frame(width: 14, height: 7)
                    }
                    
                    
                    
                }
                
                if isPaymentExpanding {
                    ClientDefenceTrainingItem()
                }
                
            }
            .padding(.horizontal)
            
            
            
            //Booked Sessions
            VStack(alignment: .leading) {
                HStack{
                    Text("Booked Sessions")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                        withAnimation {
                            isBookedExpanding.toggle()
                        }
                    } label: {
                        Image(systemName: isBookedExpanding ? "chevron.up" : "chevron.down")
                            .foregroundColor(.black)
                            .frame(width: 14, height: 7)
                    }
                    
                    
                    
                }
                
                if isBookedExpanding {
                    ClientBookedSessionExpanded()
                }
                
            }
            .padding(.horizontal)
            
            
            
            
            //Session History
            VStack(alignment: .leading) {
                HStack{
                    Text("Session History")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                        withAnimation {
                            isHistoryExpanding.toggle()
                        }
                    } label: {
                        Image(systemName: isHistoryExpanding ? "chevron.up" : "chevron.down")
                            .foregroundColor(.black)
                            .frame(width: 14, height: 7)
                    }
                    
                    
                    
                }
                
                if isHistoryExpanding {
                   ClientSessionHistoryExpanded()
                }
                
            }
            .padding(.horizontal)
            
            
            
            //Notes
            VStack(alignment: .leading) {
                HStack{
                    Text("Notes")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                        withAnimation {
                            isNotesExpanding.toggle()
                        }
                    } label: {
                        Image(systemName: isNotesExpanding ? "chevron.up" : "chevron.down")
                            .foregroundColor(.black)
                            .frame(width: 14, height: 7)
                    }
                }
                
                if isNotesExpanding {
                    ClientNotesExpanded()
                }
                
            }
            .padding(.horizontal)
            
            
        }
    }
}

struct ExpandableClientProfile_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableClientProfile()
    }
}
