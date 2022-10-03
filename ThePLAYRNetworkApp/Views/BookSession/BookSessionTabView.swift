//
//  BookSessionTabView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/24/22.
//

import SwiftUI

struct BookSessionTabView: View {
        @State private var selectedTab: Int = 0
    
        let tabs: [SessionTab] = [
//            .init(icon: Image("calendar"), title: "Availability"),
//            .init(icon: Image("review"), title: "Review")
            
            .init(title: "Availability"),
            .init(title: "Review")
        ]
    
        init() {
            let appearance = UINavigationBarAppearance()
       appearance.configureWithOpaqueBackground()
           appearance.backgroundColor = UIColor(.white)
           UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
      UINavigationBar.appearance().isTranslucent = false
        }
    
    
    
    
        var body: some View {
   
           GeometryReader { geo in
                    VStack(spacing: 0) {
                        // Tabs
//                        Tabs(tabs: tabs, geoWidth: geo.size.width, selectedTab: $selectedTab)
    
                        
                        
                        Tabs(tabs: tabs, geoWidth: geo.size.width, selectedTab: $selectedTab)
                        // Views
                        TabView(selection: $selectedTab,
                                content: {
                                   AvailabilityView()
                                        .tag(0)
                                    ReviewsView()
                                        .tag(1)
                                  
                                })
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                    .foregroundColor(.black)
                    .navigationBarTitleDisplayMode(.inline)
                    .ignoresSafeArea()
           }

        }
    
    
    
}





/*
struct BookSessionTabView: View {
    @State private var selectedIndex = 0
    @State var currentTab: Int = 0
    var body: some View {

        ZStack(alignment: .top) {
            TabView(selection: self.$currentTab) {
                AvailabilityView().tag(0)
                ReviewsView().tag(1)

            }
            .tabViewStyle(.page(indexDisplayMode: .never))
          //  .edgesIgnoringSafeArea(.all)

            TabBarView(currentTab: self.$currentTab)
        }
        
            

//                TabView(selection: $selectedIndex) {
//            AvailabilityView()
//                .onTapGesture {
//                    self.selectedIndex = 0
//                }
//                .tabItem {
////                    CalendarTab()
////                    .frame(width: 20, height: 20)
//                    Image(systemName: "calendar")
//                        .foregroundColor(.black)
//                }.tag(0)
//
//
//            ReviewsView()
//                .onTapGesture {
//                    self.selectedIndex = 1
//                }
//                .tabItem {
//                    ReviewTab()
//                        .frame(width: 30, height: 30)
//
////                   Image(systemName: "star")
//   //                     .foregroundColor(.black)
//                }.tag(1)
//        }
            

        
    //    }
        
        
        
        
        
    }
}

struct BookSessionTabView_Previews: PreviewProvider {
    static var previews: some View {
      BookSessionTabView()
 
    
    }
}

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    
    var tabBarOptions: [Image] = [ Image("calendar")
        .resizable()
     
                                   
                                   , Image("review")]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(zip(self.tabBarOptions.indices,
                                  self.tabBarOptions)),
                        id: \.0,
                        content: {
                    index, name in
                    TabBarItem(currentTab: self.$currentTab,
                               namespace: namespace.self,
                               tabBarItemImage: name,
                               tab: index)
                    Spacer()
                    
                })
            }
            .padding(.horizontal)
        }
        .background(Color.white)
        .frame(height: 80)
        .border(.blue)
       // .edgesIgnoringSafeArea(.all)
    }
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    var tabBarItemImage: Image
    var tab: Int
    
    var body: some View {
        Button {
            self.currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(tabBarItemImage)
                    .font(.largeTitle)
                if currentTab == tab {
                    Color.black
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "underline",
                                               in: namespace,
                                               properties: .frame)
           
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: self.currentTab)
        }
        .buttonStyle(.plain)
    }
}
*/

