//
//  DbService.swift
//  Taskstir
//
//  Created by Sothy Chan on 11/23/16.
//  Copyright © 2016 Foodstir. All rights reserved.
//

import SQLite

class DbService {
    
    var path: String
    var db: Connection?
    
    init() {
        path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first! + Bundle.main.bundleIdentifier!
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            db = try Connection("\(path)/db.sqlite3")
            print("Successfully connected to db")
        } catch {
            print("Unable to connect to db: \(error)")
            db = nil
        }
    }
    
    func getTable(tableName: String) -> Table {
        return Table(tableName)
    }
    
    func dropTable(tableName: String) {
        do {
            try db!.run(Table(tableName).drop())
        } catch {
            print("Error dropping table: \(tableName) due to \(error)")
        }
    }
}
