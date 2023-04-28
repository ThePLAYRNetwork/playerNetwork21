//
//  CourtTest.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 10/16/22.
//

import SwiftUI

struct CourtView: View {
    @EnvironmentObject var journalViewModel: JournalViewModel
    let topRectangleHeight = 100.0
    let skinnerRectWidth = 50.0 // adjust this, everything is setup to match
    let isHeatMap: Bool
    
    func handleSectionColor(section: CourtSection) -> Color {
//        return Color.white
//        if isHeatMap {
//            let percent = Int((Double(journalViewModel.currentJournal.scores[section]) / Double(journalViewModel.currentJournal.attempts[section])) * 100)
//            if percent < 50 {
//                return Color.ui.court_color_red
//            } else if percent < 75 {
//                return Color.ui.court_color_yellow
//            } else {
//                return Color.ui.court_color_green
//            }
//        } else {
            return journalViewModel.selectedCourtSection == section ? Color.ui.accent_light : Color.white
//        }
    }
        
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                // BOTTOM RECT
                HStack(alignment: .top, spacing: 0) {
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                        .background(Rectangle().foregroundColor(handleSectionColor(section: .leftWing)))
                        .onTapGesture {
                            journalViewModel.selectedCourtSection = .leftWing
                        }
                        .overlay(alignment: .bottom) {
                            ShotsMadeView(
                                selectedDisplay: $journalViewModel.selectedDisplay,
                                score: journalViewModel.currentJournal.leftWingScore,
                                attempt: journalViewModel.currentJournal.leftWingAttempt
                            )
                            .padding(.bottom)
                        }
                    
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                        .background(Rectangle().foregroundColor(handleSectionColor(section: .leftShot)))
                        .frame(width: skinnerRectWidth)
                        .onTapGesture {
                            journalViewModel.selectedCourtSection = .leftShot
                        }
                        .overlay(alignment: .bottom) {
                            ShotsMadeView(
                                selectedDisplay: $journalViewModel.selectedDisplay,
                                score: journalViewModel.currentJournal.leftShotScore,
                                attempt: journalViewModel.currentJournal.leftShotAttempt
                            )
                            .padding(.bottom)
                        }
                    
                
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                        .background(Rectangle().foregroundColor(handleSectionColor(section: .topOfTheKey)))
                        .onTapGesture {
                            journalViewModel.selectedCourtSection = .topOfTheKey
                        }
                        .overlay(alignment: .bottom) {
                            ShotsMadeView(
                                selectedDisplay: $journalViewModel.selectedDisplay,
                                score: journalViewModel.currentJournal.topOfTheKeyScore,
                                attempt: journalViewModel.currentJournal.topOfTheKeyAttempt
                            )
                            .padding(.bottom)
                        }
                    
                    
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                        .background(Rectangle().foregroundColor(handleSectionColor(section: .rightShot)))
                        .frame(width: skinnerRectWidth)
                        .onTapGesture {
                            journalViewModel.selectedCourtSection = .rightShot
                        }
                        .overlay(alignment: .bottom) {
                            ShotsMadeView(
                                selectedDisplay: $journalViewModel.selectedDisplay,
                                score: journalViewModel.currentJournal.rightShotScore,
                                attempt: journalViewModel.currentJournal.rightShotAttempt
                            )
                            .padding(.bottom)
                        }
                    
                    
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                        .background(Rectangle().foregroundColor(handleSectionColor(section: .rightWing)))
                        .onTapGesture {
                            journalViewModel.selectedCourtSection = .rightWing
                        }
                        .overlay(alignment: .bottom) {
                            ShotsMadeView(
                                selectedDisplay: $journalViewModel.selectedDisplay,
                                score: journalViewModel.currentJournal.rightWingScore,
                                attempt: journalViewModel.currentJournal.rightWingAttempt
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
                            .background(Rectangle().foregroundColor(handleSectionColor(section: .leftCorner)))
                            .frame(width: skinnerRectWidth)
                            .onTapGesture {
                                journalViewModel.selectedCourtSection = .leftCorner
                            }
                            .overlay(alignment: .bottom) {
                                ShotsMadeView(
                                    selectedDisplay: $journalViewModel.selectedDisplay,
                                    score: journalViewModel.currentJournal.leftCornerScore,
                                    attempt: journalViewModel.currentJournal.leftCornerAttempt
                                )
                                .padding(.bottom)
                            }
                        
                        
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                            .background(Rectangle().foregroundColor(handleSectionColor(section: .leftShortCorner)))
                            .onTapGesture {
                                journalViewModel.selectedCourtSection = .leftShortCorner
                            }
                            .overlay(alignment: .bottom) {
                                ShotsMadeView(
                                    selectedDisplay: $journalViewModel.selectedDisplay,
                                    score: journalViewModel.currentJournal.leftShortCornerScore,
                                    attempt: journalViewModel.currentJournal.leftShortCornerAttempt
                                )
                                .padding(.bottom)
                            }
                        
                        
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                            .background(Rectangle().foregroundColor(handleSectionColor(section: .paint)))
                            .onTapGesture {
                                journalViewModel.selectedCourtSection = .paint
                            }
                            .overlay(alignment: .bottom) {
                                ShotsMadeView(
                                    selectedDisplay: $journalViewModel.selectedDisplay,
                                    score: journalViewModel.currentJournal.paintScore,
                                    attempt: journalViewModel.currentJournal.paintAttempt
                                )
                                .padding(.bottom)
                            }
                        
                        
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                            .background(Rectangle().foregroundColor(handleSectionColor(section: .rightShortCorner)))
                            .onTapGesture {
                                journalViewModel.selectedCourtSection = .rightShortCorner
                            }
                            .overlay(alignment: .bottom) {
                                ShotsMadeView(
                                    selectedDisplay: $journalViewModel.selectedDisplay,
                                    score: journalViewModel.currentJournal.rightShortCornerScore,
                                    attempt: journalViewModel.currentJournal.rightShortCornerAttempt
                                )
                                .padding(.bottom)
                            }
                        
                        
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                            .background(Rectangle().foregroundColor(handleSectionColor(section: .rightCorner)))
                            .frame(width: skinnerRectWidth)
                            .onTapGesture {
                                journalViewModel.selectedCourtSection = .rightCorner
                            }
                            .overlay(alignment: .bottom) {
                                ShotsMadeView(
                                    selectedDisplay: $journalViewModel.selectedDisplay,
                                    score: journalViewModel.currentJournal.rightCornerScore,
                                    attempt: journalViewModel.currentJournal.rightCornerAttempt
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
                                .background(LeftCurvedCircle().foregroundColor(handleSectionColor(section: .leftMidRange)))
                                .frame(width: (geometry.size.width - (skinnerRectWidth * 2)) / 3, height: 110)
                                .onTapGesture {
                                    journalViewModel.selectedCourtSection = .leftMidRange
                                }
                                .overlay(alignment: .center) {
                                    ShotsMadeView(
                                        selectedDisplay: $journalViewModel.selectedDisplay,
                                        score: journalViewModel.currentJournal.leftMidRangeScore,
                                        attempt: journalViewModel.currentJournal.leftMidRangeAttempt
                                    )
                                }
                            
                            
                            Rectangle()
                                .stroke(Color.black, lineWidth: 1)
                                .background(Rectangle().foregroundColor(handleSectionColor(section: .freeThrow)))
                                .frame(width: (geometry.size.width - (skinnerRectWidth * 2)) / 3, height: 110)
                                .onTapGesture {
                                    journalViewModel.selectedCourtSection = .freeThrow
                                }
                                .overlay(alignment: .bottom) {
                                    ShotsMadeView(
                                        selectedDisplay: $journalViewModel.selectedDisplay,
                                        score: journalViewModel.currentJournal.freeThrowScore,
                                        attempt: journalViewModel.currentJournal.freeThrowAttempt
                                    )
                                    .padding(.bottom, 6)
                                }
                            
                            RightCurvedCircle()
                                .stroke(Color.black, lineWidth: 1)
                                .background(RightCurvedCircle().foregroundColor(handleSectionColor(section: .rightMidRange)))
                                .frame(width: (geometry.size.width - (skinnerRectWidth * 2)) / 3, height: 110)
                                .onTapGesture {
                                    journalViewModel.selectedCourtSection = .rightMidRange
                                }
                                .overlay(alignment: .center) {
                                    ShotsMadeView(
                                        selectedDisplay: $journalViewModel.selectedDisplay,
                                        score: journalViewModel.currentJournal.rightMidRangeScore,
                                        attempt: journalViewModel.currentJournal.rightMidRangeAttempt
                                    )
                                }
                            
                        }
                        
                        // MIDDLE
                        CurvedSidedRectangle()
                            .stroke(Color.black, lineWidth: 1)
                            .background(CurvedSidedRectangle().foregroundColor(handleSectionColor(section: .middleMidRange))) // hitbox!
                            .frame(width: (geometry.size.width - (skinnerRectWidth * 2)) / 3, height: 40)
                            .onTapGesture {
                                journalViewModel.selectedCourtSection = .middleMidRange
                            }
                            .overlay(alignment: .bottom) {
                                ShotsMadeView(
                                    selectedDisplay: $journalViewModel.selectedDisplay,
                                    score: journalViewModel.currentJournal.middleMidRangeScore,
                                    attempt: journalViewModel.currentJournal.middleMidRangeAttempt
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
        CourtView(isHeatMap: false)
            .environmentObject(JournalViewModel())
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
