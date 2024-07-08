//
//  String+Date.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 06/07/24.
//

import Foundation

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss'Z'")-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}
