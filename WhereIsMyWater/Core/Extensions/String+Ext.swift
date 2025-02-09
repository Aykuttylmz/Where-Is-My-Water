//
//  ProjectExts.swift
//  WhereIsMyWater
//
//  Created by Aykut Türkyılmaz on 5.02.2025.
//

import Foundation


extension String {
    
    func capitalizeFirstLetter() -> String {
        guard let first = first else { return "" }
        return first.uppercased() + dropFirst()
    }
    
    func formatDate() -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputDateFormatter.timeZone = .current
        
        if let date = inputDateFormatter.date(from: self) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            return outputDateFormatter.string(from: date)
        } else {
            return "N/A"
        }
    }
    
}
