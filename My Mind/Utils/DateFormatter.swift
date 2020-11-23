//
//  DateFormatter.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-23.
//

import Foundation

extension String {
    
    func formatDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: self) else { return ""}
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "d MMM y"
        
        return formatter3.string(from: date)
    }
    
    
}
