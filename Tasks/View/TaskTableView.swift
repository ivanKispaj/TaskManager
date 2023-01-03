//
//  TaskTableView.swift
//  Tasks
//
//  Created by Ivan Konishchev on 24.12.2022.
//
// The main page of the application!
// There is an opportunity to create a new task and change an existing one.
//
//


import SwiftUI
import CoreData

struct TaskTableView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // CoreData result
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ListTasks.header, ascending: true)],
        animation: .default)
    private var items: FetchedResults<ListTasks>
    
    // viewvModel
    @ObservedObject private var viewModel: TaskViewModel = TaskViewModel()
    
    // Name of the current month
    var monthName: String = {
        let date = Date()
        return date.getMonth()
    }()
    // Number of tasks in the application
    @State var countTask: String = "0"
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(items, id: \.id) { item in
                    Section {
                        if let tasks = item.sortedTask {
                            ForEach(tasks) { task in
                                
                                NavigationLink {
                                    TaskItemView(task: task, list: item, headerTask: self.viewModel.getTaskHeader(task), textTask: self.viewModel.getTaskText(task))
                                } label: {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(.init(self.viewModel.getTaskHeader(task)))
                                            
                                        }
                                        HStack {
                                            if let date = task.date {
                                                Text(self.viewModel.itemFormatter.string(from: date))
                                            }
                                            if task.text?.string == "DelitedFull#195674" {
                                                Text("")
                                                    .onAppear{
                                                        self.deliteTask(from: item, task: task)
                                                    }
                                            }
                                        }
                                        
                                    }
                                    .onAppear {
                                        self.getCount()
                                    }
                                }
                                
                            }
                            
                            .onDelete { row in
                                self.deliteItem(from: item, in: row)
                                
                            }
                            
                        }
                    } header: {
                        if let header = item.header {
                            Text(header)
                        } else {
                            Text("Uncnown")
                        }
                    }
                    
                    //                    Section(item.header!) {
                    //
                    //                     //   if let tasks = item.task?.allObjects as? [TaskInfo] {
                    //
                    //                    }
                    
                }
                
            }
            
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem {
                    Button {
                        
                    } label: {
                        NavigationLink {
                            TaskItemView(list: items.first(where: { $0.header == monthName }))
                        } label: {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                    
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Text("Всего заметок: \(self.countTask)")
                }
            }
            
            
        }
    }
    
    
    // Method for deleting a task
    //
    // The input gets the section in which the current task
    // is located and the IndexSet of the task being deleted
    //
    // If the task is the last in the section, then the section is deleted
    //
    
    private func deliteTask(from section: ListTasks, task: TaskInfo) {
        section.removeFromTask(task)
        if let taskArray = section.task?.allObjects as? [TaskInfo] , taskArray.count <= 0 {
            // If there are no tasks left in the section, then delete the section
            viewContext.delete(section)
        }
        getCount()
    }
    private func deliteItem(from section: ListTasks, in row: IndexSet) {
        
        let index = row.first!
        let task = section.sortedTask[index]
        section.removeFromTask(task)
        
        if let taskArray = section.task?.allObjects as? [TaskInfo] , taskArray.count <= 0 {
            // If there are no tasks left in the section, then delete the section
            viewContext.delete(section)
        }
        
        do {
            // saving the result in Core Data
            try viewContext.save()
            // requesting recalculation of the remaining tasks
            getCount()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
    
    // method for getting the count of all tasks
    private func getCount()  {
        var count = 0
        for task in items {
            if let int = task.task?.count {
                count += int
            }
        }
        self.countTask = String(count)
    }
}
