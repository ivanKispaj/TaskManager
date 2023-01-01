//
//  chunk.swift
//  Tasks
//
//  Created by Ivan Konishchev on 30.12.2022.
//

import Foundation

// MARK: - Returns a string of the specified length, if the string is shorter than the specified length, it will return the original string

extension String {

    func chunk(_ leingth: Int) -> String {
        if self.count > leingth {
            let startIndex = self.index(self.startIndex, offsetBy: 0)
            let endIndex = self.index(self.startIndex, offsetBy: leingth)
            return String(self[startIndex..<endIndex])
        } else {
            return self
        }
    }
}
