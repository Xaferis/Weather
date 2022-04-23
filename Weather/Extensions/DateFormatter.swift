//
//  DateFormatter.swift
//  Weather
//
//  Created by Matúš Mištrik on 23/04/2022.
//

import Foundation

extension DateFormatter {
    
    static let dayDateFormattter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter
    }()
}
