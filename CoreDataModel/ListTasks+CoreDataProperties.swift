//
//  ListTasks+CoreDataProperties.swift
//  Tasks
//
//  Created by Ivan Konishchev on 25.12.2022.
//
//

import Foundation
import CoreData


extension ListTasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListTasks> {
        return NSFetchRequest<ListTasks>(entityName: "ListTasks")
    }

    @NSManaged public var header: String?
    @NSManaged public var task: NSSet?
    // массив отсортированных задач
    var sortedTask: [TaskInfo] {
        let taskInfo: [TaskInfo] = (task?.allObjects as? [TaskInfo])!
        return taskInfo.sorted { firstTask, nextTask in
            if let dateFirst = firstTask.date, let dateNext = nextTask.date {
                return dateFirst > dateNext
            }
            return false
           
        }
    }

}

// MARK: Generated accessors for task
extension ListTasks {

    @objc(addTaskObject:)
    @NSManaged public func addToTask(_ value: TaskInfo)

    @objc(removeTaskObject:)
    @NSManaged public func removeFromTask(_ value: TaskInfo)

    @objc(addTask:)
    @NSManaged public func addToTask(_ values: NSSet)

    @objc(removeTask:)
    @NSManaged public func removeFromTask(_ values: NSSet)

}

extension ListTasks : Identifiable {

}
