//
//  Date+String.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 06/07/24.
//

import Foundation

extension Date {
    
    func displayStringFromDate() -> String {
        let fromDate = self
        let toDate = Date()
        
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            return interval == 1 ? "\(interval)" + " " + "year before".localize() : "\(interval)" + " " + "years before".localize()
        }
        
        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
            return interval == 1 ? "\(interval)" + " " + "month before".localize() : "\(interval)" + " " + "months before".localize()
        }
        
        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            return interval == 1 ? "\(interval)" + " " + "day before".localize() : "\(interval)" + " " + "days before".localize()
        }
        
        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "hour".localize() : "\(interval)" + " " + "hours".localize()
        }
        
        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "min".localize() : "\(interval)" + " " + "mins".localize()
        }
        
        // Second
        if let interval = Calendar.current.dateComponents([.second], from: fromDate, to: toDate).second, interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "second".localize() : "\(interval)" + " " + "seconds".localize()
        }
        return "NA"
    }
    
    func displayTime() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
