//
//  TaskInfo+CoreDataProperties.swift
//  Tasks
//
//  Created by Ivan Konishchev on 30.12.2022.
//
//

import Foundation
import CoreData


extension TaskInfo: Comparable {
    public static func < (lhs: TaskInfo, rhs: TaskInfo) -> Bool {
        lhs.date == rhs.date && lhs.text == rhs.text && lhs.parent == rhs.parent
    }
    

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskInfo> {
        return NSFetchRequest<TaskInfo>(entityName: "TaskInfo")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: NSAttributedString?
    @NSManaged public var parent: ListTasks?

}

extension TaskInfo : Identifiable {

}
