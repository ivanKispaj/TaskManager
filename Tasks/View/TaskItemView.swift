//
//  TaskItem.swift
//  Tasks
//
//  Created by Ivan Konishchev on 24.12.2022.
//

import Foundation
import SwiftUI
import TextEditor

struct TaskItemView: View {
    @EnvironmentObject var scene: SceneDelegate
    @Environment(\.managedObjectContext) private var viewContext
    // The task itself passed to the view
    @State var task: TaskInfo?
    // The section to which the task belongs
    @State var list: ListTasks?
    // Text for the task title
    @State var headerTask = NSAttributedString()
    // The text for the task itself
    @State var textTask = NSAttributedString()

    var deviceFrame: CGRect {
        if let frame = scene.sceneSize {
            return frame
        } else {
            return CGRect(x: 0, y: 0, width: 0, height: 0)
        }
    }
    var body: some View {
        
        ScrollView(.vertical ,showsIndicators: false) {
                
                HStack {
                    
                    TextEditor(attributedText: NSMutableAttributedString(attributedString: textTask) , deviceFrame: deviceFrame, onCommit: { text in
                        self.textTask = text
                    })
                    
                }
            
                .onDisappear {
                    self.addTask()
                }
            
        }
        
    }
    
    // MARK: - Method for adding a task to the task list
    private func addTask() {
        
        let editList: ListTasks
        // Current date
        let date = Date()
        // Name of the current month
        let month = date.getMonth()
        
        // If there is a section and an old task in it!
        // Then you need to replace the task in the section
        if let list = self.list, let oldtask = self.task {
            editList = list
            list.header = month
            list.removeFromTask(oldtask)
            // Otherwise, if there is a section, but an empty task,
            // then update the task in the section
        } else if let list = self.list {
            editList = list
            
            // Otherwise, we create a new section with the current month
        } else {
            
            let newList = ListTasks(context: viewContext)
            newList.header = month
            editList = newList
        }
        // we add the task to the options that came up by choice
        let task = TaskInfo(context: viewContext)
        
        // task.header = headerTask
        if !textTask.string.isEmpty {
            task.text = textTask
        } else {
            let attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 24)!,
                              NSAttributedString.Key.foregroundColor: UIColor(named: "whiteBlack")]
            task.text = NSMutableAttributedString(string: "DelitedFull#195674", attributes: attributes as [NSAttributedString.Key : Any])
            task.date = date
        }
        task.date = date
        editList.addToTask(task)
        
        
        do {
            // Saving data in Core Data
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
