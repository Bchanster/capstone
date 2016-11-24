//
//  TaskService.swift
//  Taskstir
//
//  Created by Sothy Chan on 11/23/16.
//  Copyright © 2016 Foodstir. All rights reserved.
//

import SQLite

class TaskService {
    
    var dbService: DbService
    var tasks: Table
    var id: Expression<Int64>
    var name: Expression<String>
    var date: Expression<String>
    var description: Expression<String>
    var isCompleted: Expression<Bool>
    
    init(dbService: DbService) {
        print("Creating task service")
        self.dbService = dbService
        self.id = Expression<Int64>("id")
        self.name = Expression<String>("name")
        self.date = Expression<String>("date")
        self.description = Expression<String>("description")
        self.isCompleted = Expression<Bool>("isCompleted")
        self.tasks = dbService.getTable(tableName: "tasks")
    }
    
    func createTasksTable() {
        do {
            try dbService.db!.run(tasks.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(date)
                t.column(description)
                t.column(isCompleted)
            })
        } catch {
            print("Error creating tasks table \(error)")
        }
    }
    
    func dropTable() {
        do {
            try dbService.db!.run(tasks.drop(ifExists: true))
            print("Dropped tasks table")
        } catch {
            print("Error dropping tasks table \(error)")
        }
    }
    
    func createTask() {
        do {
            let rowid = try dbService.db!.run(tasks.insert(name <- "test task", date <- "November 25, 2016", description <- "Just a test task", isCompleted <- false))
            print("inserted new task: \(rowid)")
            
        } catch {
            print("Error saving to database \(error)")
        }
    }
}
