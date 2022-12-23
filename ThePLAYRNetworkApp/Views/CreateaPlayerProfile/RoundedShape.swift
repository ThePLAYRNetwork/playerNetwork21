//
//  RoundedShape.swift
//  TwitterSwiftUIYoutube
//
//  Created by Mirna Helmy on 3/9/22.
//

import SwiftUI


struct RoundedShape: Shape {
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,byRoundingCorners: corners, cornerRadii: CGSize(width: 20, height: 0))
        
        return Path(path.cgPath)
    }
}
