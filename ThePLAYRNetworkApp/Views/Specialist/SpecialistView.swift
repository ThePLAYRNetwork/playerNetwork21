//
//  SpecialistView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/29/22.
//

import SwiftUI
import _MapKit_SwiftUI

struct SpecialistView: View {
    @State var searchText: String = ""
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.334_900,
                                           longitude: -122.009_020),
            latitudinalMeters: 750,
            longitudinalMeters: 750
        )
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $region)
            
            VStack(spacing: 0) {
                VStack {
                    VStack(alignment: .leading) {
                        Button(action: {}) {
                            Image(systemName: "arrow.backward")
                                .resizable()
                                .frame(width: 21, height: 18)
                        }
                        .buttonStyle(.plain)
                        .padding(.bottom)
                        
                        Text("Weight Specialists")
                            .font(.system(size: 24, weight: .bold))
                        
                        SearchBar(text: $searchText)
                    }
                    .padding([.top, .horizontal])
                    
                    DiscoverFilterRow()
                }
                .background()
                
                SpecialistSheetView()
                    .zIndex(-1) // Top layer.
//                    .border(.red)
            }
        }
    }
}

struct SpecialistView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialistView()
    }
}
