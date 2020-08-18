//
//  Date+Extension.swift
//  JournalCK35
//
//  Created by Alex Lundquist on 8/17/20.
//

import Foundation
extension Date {
    
    func formateDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
