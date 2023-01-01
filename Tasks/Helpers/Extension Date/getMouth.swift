//
//  ExtensionDate.swift
//  Tasks
//
//  Created by Ivan Konishchev on 25.12.2022.
//
// Extension for Date. Which returns the name of the current month.

import Foundation

// MARK: - Using
// let month: String = date.getMonth()
extension Date {
    
    func getMonth() -> String {
        let mouth = Calendar.current.component(.month, from: self)
        switch mouth {
        case 1:
            return  "Январь"
        case 2:
            return  "Февраль"
        case 3:
            return  "Март"
        case 4:
            return  "Апрель"
        case 5:
            return  "Май"
        case 6:
            return  "Июнь"
        case 7:
            return  "Июль"
        case 8:
            return  "Август"
        case 9:
            return  "Сентябрь"
        case 10:
            return  "Октябрь"
        case 11:
            return  "Ноябрь"
        default:
            return  "Декабрь"
        }
    }
}
