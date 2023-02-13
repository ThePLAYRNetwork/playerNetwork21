//
//  CourtTest.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 10/16/22.
//

import SwiftUI

struct CourtView: View {
    @ObservedObject var journalViewModel: JournalViewModel
    let topRectangleHeight = 100.0
    let skinnerRectWidth = 50.0 // adjust this, everything is setup to match
    let isHeatMap: Bool
    
    func handleSectionColor(section: Int) -> Color {
        if isHeatMap {
            let percent = Int((Double(journalViewModel.courtData.score[section]) / Double(journalViewModel.courtData.attempts[section])) * 100)
            if percent < 50 {
                return Color.ui.court_color_red
            } else if percent < 75 {
                return Color.ui.court_color_yellow
            } else {
                return Color.ui.court_color_green
            }
        } else {
            return journalViewModel.courtData.selection == section ? Color.ui.accent_light : Color.white
        }
    }
        
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                // BOTTOM RECT
                HStack(alignment: .top, spacing: 0) {
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                        .background(Rectangle().foregroundColor(handleSectionColor(section: 9)))
                        .onTapGesture {
                            // TODO: Maybe add slight animation delay instead of instant
                            //                            withAnimation(.interactiveSpring(
                            //                                response: 0.1, dampingFraction: 1.5, blendDuration: 0.5)) {
                            //                                    courtData.selection = 9
                            //                            }
                            journalViewModel.courtData.selection = 9
                        }
                        .overlay(alignment: .bottom) {
                            ShotsMadeView(
                                selectedDisplay: $journalViewModel.selectedDisplay,
                                score: journalViewModel.courtData.score[9],
                                attempt: journalViewModel.courtData.attempts[9]
                            )
                            .padding(.bottom)
                        }
                    
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                        .background(Rectangle().foregroundColor(handleSectionColor(section: 10)))
                        .frame(width: skinnerRectWidth)
                        .onTapGesture {
                            journalViewModel.courtData.selection = 10
                        }
                        .overlay(alignment: .bottom) {
                            ShotsMadeView(
                                selectedDisplay: $journalViewModel.selectedDisplay,
                                score: journalViewModel.courtData.score[10],
                                attempt: journalViewModel.courtData.attempts[10]
                            )
                            .padding(.bottom)
                        }
                    
                
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                        .background(Rectangle().foregroundColor(handleSectionColor(section: 11)))
                        .onTapGesture {
                            journalViewModel.courtData.selection = 11
                        }
                        .overlay(alignment: .bottom) {
                            ShotsMadeView(
                                selectedDisplay: $journalViewModel.selectedDisplay,
                                score: journalViewModel.courtData.score[11],
                                attempt: journalViewModel.courtData.attempts[11]
                            )
                            .padding(.bottom)
                        }
                    
                    
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                        .background(Rectangle().foregroundColor(handleSectionColor(section: 12)))
                        .frame(width: skinnerRectWidth)
                        .onTapGesture {
                            journalViewModel.courtData.selection = 12
                        }
                        .overlay(alignment: .bottom) {
                            ShotsMadeView(
                                selectedDisplay: $journalViewModel.selectedDisplay,
                                score: journalViewModel.courtData.score[12],
                                attempt: journalViewModel.courtData.attempts[12]
                            )
                            .padding(.bottom)
                        }
                    
                    
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                        .background(Rectangle().foregroundColor(handleSectionColor(section: 13)))
                        .onTapGesture {
                            journalViewModel.courtData.selection = 13
                        }
                        .overlay(alignment: .bottom) {
                            ShotsMadeView(
                                selectedDisplay: $journalViewModel.selectedDisplay,
                                score: journalViewModel.courtData.score[13],
                                attempt: journalViewModel.courtData.attempts[13]
                            )
                            .padding(.bottom)
                        }
                    
                }
                
                // TOP RECT
                VStack(alignment: .center, spacing: 0) {
                    // Red
                    HStack(alignment: .top, spacing: 0) {
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                            .background(Rectangle().foregroundColor(handleSectionColor(section: 0)))
                            .frame(width: skinnerRectWidth)
                            .onTapGesture {
                                journalViewModel.courtData.selection = 0
                            }
                            .overlay(alignment: .bottom) {
                                ShotsMadeView(
                                    selectedDisplay: $journalViewModel.selectedDisplay,
                                    score: journalViewModel.courtData.score[0],
                                    attempt: journalViewModel.courtData.attempts[0]
                                )
                                .padding(.bottom)
                            }
                        
                        
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                            .background(Rectangle().foregroundColor(handleSectionColor(section: 1)))
                            .onTapGesture {
                                journalViewModel.courtData.selection = 1
                            }
                            .overlay(alignment: .bottom) {
                                ShotsMadeView(
                                    selectedDisplay: $journalViewModel.selectedDisplay,
                                    score: journalViewModel.courtData.score[1],
                                    attempt: journalViewModel.courtData.attempts[1]
                                )
                                .padding(.bottom)
                            }
                        
                        
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                            .background(Rectangle().foregroundColor(handleSectionColor(section: 2)))
                            .onTapGesture {
                                journalViewModel.courtData.selection = 2
                            }
                            .overlay(alignment: .bottom) {
                                ShotsMadeView(
                                    selectedDisplay: $journalViewModel.selectedDisplay,
                                    score: journalViewModel.courtData.score[2],
                                    attempt: journalViewModel.courtData.attempts[2]
                                )
                                .padding(.bottom)
                            }
                        
                        
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                            .background(Rectangle().foregroundColor(handleSectionColor(section: 3)))
                            .onTapGesture {
                                journalViewModel.courtData.selection = 3
                            }
                            .overlay(alignment: .bottom) {
                                ShotsMadeView(
                                    selectedDisplay: $journalViewModel.selectedDisplay,
                                    score: journalViewModel.courtData.score[3],
                                    attempt: journalViewModel.courtData.attempts[3]
                                )
                                .padding(.bottom)
                            }
                        
                        
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                            .background(Rectangle().foregroundColor(handleSectionColor(section: 4)))
                            .frame(width: skinnerRectWidth)
                            .onTapGesture {
                                journalViewModel.courtData.selection = 4
                            }
                            .overlay(alignment: .bottom) {
                                ShotsMadeView(
                                    selectedDisplay: $journalViewModel.selectedDisplay,
                                    score: journalViewModel.courtData.score[4],
                                    attempt: journalViewModel.courtData.attempts[4]
                                )
                                .padding(.bottom)
                            }
                        
                        
                    }
                    .frame(height: topRectangleHeight)
                    
                    ZStack(alignment: .top) {
                        // BOTTOM MIDDLE
                        HStack(alignment: .top, spacing: 0) {
                            LeftCurvedCircle()
                                .stroke(Color.black, lineWidth: 1)
                                .background(LeftCurvedCircle().foregroundColor(handleSectionColor(section: 6)))
                                .frame(width: (geometry.size.width - (skinnerRectWidth * 2)) / 3, height: 110)
                                .onTapGesture {
                                    journalViewModel.courtData.selection = 6
                                }
                                .overlay(alignment: .center) {
                                    ShotsMadeView(
                                        selectedDisplay: $journalViewModel.selectedDisplay,
                                        score: journalViewModel.courtData.score[6],
                                        attempt: journalViewModel.courtData.attempts[6]
                                    )
                                }
                            
                            
                            Rectangle()
                                .stroke(Color.black, lineWidth: 1)
                                .background(Rectangle().foregroundColor(handleSectionColor(section: 7)))
                                .frame(width: (geometry.size.width - (skinnerRectWidth * 2)) / 3, height: 110)
                                .onTapGesture {
                                    journalViewModel.courtData.selection = 7
                                }
                                .overlay(alignment: .bottom) {
                                    ShotsMadeView(
                                        selectedDisplay: $journalViewModel.selectedDisplay,
                                        score: journalViewModel.courtData.score[7],
                                        attempt: journalViewModel.courtData.attempts[7]
                                    )
                                    .padding(.bottom, 6)
                                }
                            
                            RightCurvedCircle()
                                .stroke(Color.black, lineWidth: 1)
                                .background(RightCurvedCircle().foregroundColor(handleSectionColor(section: 8)))
                                .frame(width: (geometry.size.width - (skinnerRectWidth * 2)) / 3, height: 110)
                                .onTapGesture {
                                    journalViewModel.courtData.selection = 8
                                }
                                .overlay(alignment: .center) {
                                    ShotsMadeView(
                                        selectedDisplay: $journalViewModel.selectedDisplay,
                                        score: journalViewModel.courtData.score[8],
                                        attempt: journalViewModel.courtData.attempts[8]
                                    )
                                }
                            
                        }
                        
                        // MIDDLE
                        CurvedSidedRectangle()
                            .stroke(Color.black, lineWidth: 1)
                            .background(CurvedSidedRectangle().foregroundColor(handleSectionColor(section: 5))) // hitbox!
                            .frame(width: (geometry.size.width - (skinnerRectWidth * 2)) / 3, height: 40)
                            .onTapGesture {
                                journalViewModel.courtData.selection = 5
                            }
                            .overlay(alignment: .bottom) {
                                ShotsMadeView(
                                    selectedDisplay: $journalViewModel.selectedDisplay,
                                    score: journalViewModel.courtData.score[5],
                                    attempt: journalViewModel.courtData.attempts[5]
                                )
                            }
                        
                    }
                    
                }
                
//                // debugg
//                Text("\(journalViewModel.courtData.selection)")
//                    .frame(maxWidth: .infinity)
            }
            .frame(height: 275)
        }
    }
    
}

struct CourtView_Previews: PreviewProvider {
    static var previews: some View {
        CourtView(journalViewModel: JournalViewModel(), isHeatMap: false)
//            .frame(width: 350, height: 300)
        
        CurvedSidedRectangle()
            .previewDisplayName("Curved Sided Rectangle")
            .frame(height: 300.0)
        
        LeftCurvedCircle()
            .previewDisplayName("Left Curved")
            .frame(height: 300)
        
//        BottomCurvedSidedRectangle()
//            .previewDisplayName("Bottom Curved Sided Rectangle")
//            .frame(height: 300.0)
    }
}

struct CurvedSidedRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint.zero) // top left
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))   // top right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // bottom right
        //        path.addQuadCurve(to: CGPoint(x: 0, y: rect.maxY),  // bottom left with curve
        //                          control: CGPoint(x: rect.midX, y: rect.maxY + 50))
        //
        path.addCurve(to: CGPoint(x: 0, y: rect.maxY),
                      control1: CGPoint(x: rect.midX + (rect.midX * 0.7), y: rect.maxY + 40),
                      control2: CGPoint(x: rect.midX - (rect.midX * 0.7), y: rect.maxY + 40)
        )
        path.closeSubpath() // optional, draw line from bottom left to start (top left)
        return path
    }
    
}

struct LeftCurvedCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint.zero) // top left
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))   // top right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // bottom right
        path.addQuadCurve(to: CGPoint(x: 0, y: 0),  // bottom left with curve
                          control: CGPoint(x: 0, y: rect.maxY))

        return path
    }
}

struct RightCurvedCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint.zero) // top left
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))   // top right
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.maxY),  // bottom left with curve
                          control: CGPoint(x: rect.maxX, y: rect.maxY))
        
        return path
    }
}

//struct BottomCurvedSidedRectangle: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        path.move(to: CGPoint.zero) // top left
//        path.addLine(to: CGPoint(x: rect.maxX, y: 0))   // top right
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // bottom right
//        //        path.addQuadCurve(to: CGPoint(x: 0, y: rect.maxY),  // bottom left with curve
//        //                          control: CGPoint(x: rect.midX, y: rect.maxY + 50))
//        //
//        path.addCurve(to: CGPoint(x: 0, y: rect.maxY),
//                      control1: CGPoint(x: rect.midX + (rect.midX * 0.5), y: rect.maxY + 40),
//                      control2: CGPoint(x: rect.midX - (rect.midX * 0.5), y: rect.maxY + 40)
//        )
//        path.closeSubpath() // optional, draw line from bottom left to start (top left)
//        return path
//    }
//
//}

struct DivideView: View {
    let score: Int
    let attempt: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Text("\(score)")
            Divider()
                .overlay(.black)
            Text("\(attempt)")
        }
        .fixedSize(horizontal: true, vertical: true)
        .font(.system(size: 10))
        // make views take up only as much space they need. i.e shrinks divider
    }
}

struct PercentView: View {
    let score: Int
    let attempt: Int
    
    var body: some View {
        Text("\(Int((Double(score) / Double(attempt)) * 100))%")
            .font(.system(size: 10))
    }
}

struct ShotsMadeView: View {
    @Binding var selectedDisplay: Int // 0 is ratio, 1 is percentage
    let score: Int
    let attempt: Int
    
    var body: some View {
        if selectedDisplay == 0 {
            DivideView(score: score, attempt: attempt)
        } else {
            PercentView(score: score, attempt: attempt)
        }
    }
}
