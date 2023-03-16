////
////  Task.swift
////  ThePLAYRNetworkApp
////
////  Created by Mirna Helmy on 8/15/22.
////
//
//import SwiftUI
//
//// Task Model and Sample Tasks...
//// Array of Tasks...
//struct Task: Identifiable{
//    var id = UUID().uuidString
//    var title: String
//    var time: Date = Date()
//    
//}
//
//// Total Task Meta View...
//struct TaskMetaData: Identifiable {
//    var id = UUID().uuidString
//    var task: [Task]
//    var taskDate: Date
//}
//
//// sample Date for Testing...
//func getSampleDate(offset: Int)->Date{
//    let calendar = Calendar.current
//    
//    let date = calendar.date(byAdding: .day, value: offset, to: Date())
//    
//    return date ?? Date()
//    
//}
//
//
////Sample tasks...
//var tasks: [TaskMetaData] = [
//  
//    TaskMetaData(task: [
//      
//        Task(title: "Talk to iJustine"),
//        Task(title: "iPhone 13 Great Design Change"),
//        Task(title: "Nothing Much Workout !!!")
//        
//    ], taskDate: getSampleDate(offset: 1)),
//    TaskMetaData(task: [
//    
//    Task(title: "Talk to Jenna Ezarik")
//    ], taskDate: getSampleDate(offset: -3)),
//     TaskMetaData(task: [
//        
//        Task(title: "Meeting with Tim Cook")
//     ], taskDate: getSampleDate(offset: -8)),
//    TaskMetaData(task: [
//        
//        Task(title: "Next Version of SwiftUI")
//    ], taskDate: getSampleDate(offset: 10)),
//        TaskMetaData(task: [
//            
//            Task(title: "Nothing Much Workout!!!")
//        ], taskDate: getSampleDate(offset: -22)),
//        TaskMetaData(task: [
//                
//            Task(title: "Kavsoft App Updates....")
//        ], taskDate: getSampleDate(offset: -20)),
//
//]
