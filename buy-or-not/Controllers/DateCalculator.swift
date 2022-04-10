//
//  DateCalculator.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/10.
//

//import Foundation
//
//class DateCalculator: ObservableObject {
//
//     var originatedDate: String = "2017-08-06T19:20:42+0000"
//     var currentDate: String = "2020-08-06T19:20:46+0000"
//    @Published var dateDiff: String
//
//    init() {
//        CalculateDifference()
//    }
//
//    func CalculateDifference() {
//        let fmt = ISO8601DateFormatter()
//        let date1 = fmt.date(from: originatedDate)!
//        let date2 = fmt.date(from: currentDate)!
//        dateDiff = String(Calendar.current.dateComponents([.day], from: date1, to: date2))
//        return dateDiff
//    }
//
//
//}
