//
//  TasksApp.swift
//  Tasks
//
//  Created by Ivan Konishchev on 24.12.2022.
//

import SwiftUI

@main
struct TasksApp: App {
    let persistenceController = PersistenceController.shared

    @AppStorage("FirstEnter") var appStatus: Bool = false
    var body: some Scene {
        WindowGroup {
            if appStatus {
                TaskTableView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                ZStack {
                    Text("Добро пожаловать в приложение!")
                    
                }
                .onAppear {
                    let month = Date().getMonth()
                    
                    let list = ListTasks(context: persistenceController.container.viewContext)
                    list.header = month
                    
                    let task = TaskInfo(context:  persistenceController.container.viewContext)
                    task.date = Date()
                   // task.header = NSAttributedString(string: "Добро пожаловать в приложение!")
                    let attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 24)!,
                                      NSAttributedString.Key.foregroundColor: UIColor(named: "whiteBlack")]
                    let header = NSMutableAttributedString(string: "Добро пожаловать\n", attributes: attributes as [NSAttributedString.Key : Any])
                    let attributesText = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
                                          NSAttributedString.Key.foregroundColor: UIColor.red]
                    let text = NSMutableAttributedString(string: "Рад видеть вас в моем приложение.\n и надеюсь вы по достоинству оцените мою работу!", attributes: attributesText)
                    header.append(text)
                    task.text = header
                    list.addToTask(task)
                    
                    do {
                    // saving the result in Core Data
                        try persistenceController.container.viewContext.save()
                        UserDefaults.standard.set(true, forKey: "FirstEnter")
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
            }
           
        }
    }
}
