//
//  TrainerHubView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/1/22.
//

import SwiftUI

struct TrainerHubView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var trainerHubVc = TrainerHubViewModel()
    @ObservedObject var coverImageViewModel =  SessionCoverImageViewModel()
//    @ObservedObject var gameCoverImageViewModel = GameCoverImageViewModel()


    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                
                
                
                ScrollView {
                    Text("Trainer Hub")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .padding(.top, 5)
                        .padding(.bottom, -5)
                    
                    VStack(alignment: .leading) {
                        NavigationLink(destination: ActiveSessionsView()) {
                            
                            AtAGlanceView()
                            
                        }
                        
                        ZStack {
                            VStack {
                                HubChartView()
                                    .frame(height: 275)
                                
                                    .overlay(
                                        Image("lchart")
                                            .resizable()
                                            .frame(width: 300,height: 150)
                                            .padding(.bottom, -50)
                                            .padding(.leading, 20)
                                    )
                                    .padding()
                                CustomSegmentedControl(
                                    selectedIndex: $trainerHubVc.selectedDateType,
                                    options: ["W", "M", "Y"],
                                    spacing: 30.0
                                )
                                .padding()
                            }
                            
                        }
                        
                        .background {
                            RoundedRectangle(cornerRadius: 17)
                                .fill(Color.ui.grayF6F6F6)
                        }
                        .padding()
                        
                        
                        
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .aspectRatio(1.0, contentMode: .fit)
                                .frame(width: 89, height: 89)
                                .overlay(
                                    NavigationLink(destination: CreateSessionView(coverImageViewModel: SessionCoverImageViewModel())) {
                                        Image("cross.square")
                                            .resizable()
                                            .frame(width: 46.94, height: 47.18)
                                            .padding(.top, 10)
                                    }
                                )
                            
                            
                            RoundedRectangle(cornerRadius: 10)
                                .aspectRatio(1.0, contentMode: .fit)
                                .frame(width: 89, height: 89)
                                .overlay(
                                    
                                    NavigationLink(destination: ActiveSessionsView()) {
                                        Image("chart")
                                            .resizable()
                                            .frame(width: 46.94, height: 47.18)
                                            .padding(.top, 10)
                                    }
                                    
                                )
                            
                            
                            
                            
                            
                            RoundedRectangle(cornerRadius: 10)
                                .aspectRatio(1.0, contentMode: .fit)
                                .frame(width: 89, height: 89)
                                .overlay(
                                    NavigationLink(destination: ClientManagementView()) {
                                        Image("personSearch")
                                            .resizable()
                                            .frame(width: 46.94, height: 47.18)
                                            .padding(.top, 10)
                                    }
                                )
                            
                            
                            RoundedRectangle(cornerRadius: 10)
                                .aspectRatio(1.0, contentMode: .fit)
                                .frame(width: 89, height: 89)
                                .overlay(
                                    NavigationLink(destination: NotesView()) {
                                        Image("book")
                                            .resizable()
                                            .frame(width: 46.94, height: 47.18)
                                            .padding(.top, 10)
                                    }
                                    
                                )
                            
                        }
                        .padding()
                        .foregroundColor(Color.ui.accentColor)
                        
                        
                        
                        //  VStack {
                        
                        
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.ui.grayF6F6F6)
                            .frame(maxWidth: .infinity, minHeight: 450)
                            .padding()
                            .overlay(
                                VStack(alignment: .leading) {
                                    Text("Current Bookings")
                                        .font(.system(size: 20, weight: .semibold))
                                        .padding(.leading, 23)
                                        .foregroundColor(.black)
                                    
                                    CalendarTrainerView(interval: DateInterval(start: .distantPast, end: .distantFuture))
                                        .padding()
                                        .frame(height: 370)
                                    
                                }
                                    .frame(height: 350)
                            )
                    }
                }
                
            }
        }
        .alert(isPresented: $homeViewModel.showingGamePosted) {
            Alert(
                title: Text("All right!"),
                message: Text("Your game has been posted."),
                dismissButton: Alert.Button.cancel()
            )
            
        }
    }
}

//struct TrainerHubView_Previews: PreviewProvider {
//    @Binding var selectedIndex: Int
//    @ObservedObject var trainerHubVc = TrainerHubViewModel()
//    static var previews: some View {
//      //  TrainerHubView(selectedIndex: JournalViewModel)
//       // AtAGlanceView()
//        CustomSegmentedControl(
//            selectedIndex: $trainerHubVc.selectedDateType,
//            options: ["W", "M", "Y"],
//            spacing: 30.0
//        )
//
//
//    }
//}







struct AtAGlanceView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("AT A GLANCE..")
                .foregroundColor(.white)
                .font(.system(size: 12))
            
            HStack {
                VStack(alignment: .leading) {
                    Text("2")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                    
                        Text("Active Sessions")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                }
                
                Divider()
                    .overlay(.white)
                    .frame(width: 15, height: 40)
                    .padding(.horizontal, 20)
                
                
                VStack(alignment: .leading) {
                    
                    HStack(alignment: .bottom) {
                        Text("10")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        Text("+5%")
                            .font(.system(size: 12))
                            .foregroundColor(.green)
                            .padding(.leading, -5)
                        Image("arrowUp")
                            .resizable()
                            .frame(width: 16, height: 10)
                            .padding(.leading, -7)
                    }
                    
                    
                    Text("Current Bookings")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                    
                    
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.black)
        .cornerRadius(10)
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
}





struct CustomSegmentedControl: View {
    @Binding var selectedIndex: Int
    var options: [String]
    let color = Color.black
    let spacing: CGFloat
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(options.indices, id:\.self) { index in
                let isSelected = selectedIndex == index
                
                Text(options[index])
                    .fontWeight(.medium)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background(Capsule().fill(isSelected ? Color.black : .clear))
                    .background(Capsule().fill(isSelected ? Color.ui.grayDADADA : .clear))
                    .foregroundColor(isSelected ? .white : .red)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(
                            response: 0.1, dampingFraction: 1.5, blendDuration: 0.5)) {
                                selectedIndex = index
                            }
                    }
            }
        }
        .background {
            Capsule()
                .fill(Color.ui.grayD9D9D9)
        }
    }
}
