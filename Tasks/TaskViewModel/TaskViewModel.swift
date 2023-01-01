//
//  TaskViewModel.swift
//  Tasks
//
//  Created by Ivan Konishchev on 25.12.2022.
//

import Foundation
import SwiftUI



final class TaskViewModel: ObservableObject {
    
    // Date formater to convert a date to string format
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    // The length of the displayed title in the task list
    let lengthHeader: Int = 20
    // The method receives a task as input,
    // and returns the text of the task without a title
    func getTaskText(_ task: TaskInfo) -> NSAttributedString {
        if let text = task.text {
            return text
        }
        return NSAttributedString(string: "")
        
    }
    // The method receives a task as input,
    // and returns the task title without text
    func getTaskHeader(_ task: TaskInfo) -> NSAttributedString {
        let header = NSMutableAttributedString()
        if let text = task.text {
            if var str = text.string.components(separatedBy: "\n").first {
                
                let headerAttr = text.attributes(at: 0, effectiveRange: nil)
                str = str.chunk(self.lengthHeader)
                header.append(NSMutableAttributedString(string: str,attributes: headerAttr))
                if str.count == lengthHeader {
                    header.append(NSAttributedString(string: "..."))
                }
                
            }
        }
        return header
    }
}





