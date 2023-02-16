//
//  GameDetailBottomSection.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 1/8/23.
//

import SwiftUI
import MapKit

struct GameDetailBottomSection: View {
//    @Binding var trackingMode: MapUserTrackingMode
//    @Binding var region: MKCoordinateRegion
//    let location: Location

    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Game Details").font(.system(size: 20)).bold()
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                .padding(.top, 7)
            
            TagView(tags: ["Anyone", "Outdoor", "Spectators Allowed", "Public"])
                .font(.footnote)
                .padding(.top, 10)
            
//            Map(coordinateRegion: $region,
//                showsUserLocation: true,
//                userTrackingMode: $trackingMode,
//                annotationItems: [location]) { location in
//                MapMarker(coordinate: location.coordinate)
//            }
//                .cornerRadius(7)
//                .frame(height: 125)
//                .padding(.top, 20)
//
            
            RoundedRectangle(cornerRadius: 7)
//                .fill(Color.ui.subheading_text)
                .frame(height: 125)
                .padding(.top, 20)
            
            Text("RIMAC Courts")
                .font(.system(size: 16, weight: .medium))
                .padding(.top, 10)
            
            Text("[9730 Hopkins Dr, La Jolla, CA 92093](https://example.com)")
                .tint(Color.ui.blue)
        }
        .padding()
    }
}

struct GameDetailBottomSection_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailBottomSection()
    }
}
