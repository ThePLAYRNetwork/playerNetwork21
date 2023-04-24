//
//  AlertView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/17/22.
//

import SwiftUI

struct AlertView: View {
    @Binding var showingAlert: Bool
    
    
    var body: some View {
        VStack {
            Image("check")
                .resizable()
                .frame(width: 103, height: 109)
                .padding(.all, 10)
            
            Text("All right!")
                .foregroundColor(.black)
                .font(.system(size:20, weight: .semibold))
            Text("Your session has been added")
                .font(.caption)
                .foregroundColor(Color.ui.gray959595)
        }
        .frame(width: 284, height: 233)
        
        .background(.white)
        .cornerRadius(12)
        .clipped()
        .onTapGesture {
            showingAlert = false
        }
    }
    
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(showingAlert: .constant(true))
    }
}
