//
//  DateCalculator.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/10.


import Foundation

class DateCalculator: ObservableObject {
    @Published var dateDiff: DateComponents
    var originatedDate: String = DateFormatter().string(from: Date())
    
    init(originatedDate: String) {
        let fmt = ISO8601DateFormatter()
        let originatedDate = fmt.date(from: originatedDate)
        
        self.dateDiff = Calendar.current.dateComponents([.minute, .day], from: originatedDate!, to: Date())
//        print("read here@@@@@@@@@@@")
//        print(dateDiff.day!)
//        print(dateDiff.minute!)
    }
}

