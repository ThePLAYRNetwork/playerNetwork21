//
//  GoingView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 1/8/23.
//

import SwiftUI

struct GoingView: View {
    var body: some View {

      // NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                //  BackButton()
                
                Text("Joined")
                    .font(.system(size: 24, weight: .semibold))
                    .padding(.top, 22)
                
                VStack(spacing: 16) {
                    ForEach(1..<10) {_ in
                        GoingCell()
                    }
                    
                }
                .padding(.top, 20)

                
                Spacer()
            }
            .padding()
           // .navigationBarBackButtonHidden(true)
            .background(Color.ui.whiteBg)
    //  }
      // .navigationBarBackButtonHidden(true)
    }
}

struct GoingView_Previews: PreviewProvider {
    static var previews: some View {
        GoingView()
    }
}
