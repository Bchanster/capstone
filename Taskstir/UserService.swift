//
//  UserService.swift
//  Taskstir
//
//  Created by Sothy Chan on 11/23/16.
//  Copyright © 2016 Foodstir. All rights reserved.
//

import SQLite

class UserService {
    
    var dbService: DbService
    var users: Table
    var id: Expression<Int64>
    var email: Expression<String>
    var firstName: Expression<String>
    var lastName: Expression<String>
    var password: Expression<String>
    
    init(dbService: DbService) {
        print("Creating user service")
        self.dbService = dbService
        self.id = Expression<Int64>("id")
        self.email = Expression<String>("email")
        self.firstName = Expression<String>("firstName")
        self.lastName = Expression<String>("lastName")
        self.password = Expression<String>("password")
        self.users = dbService.getTable(tableName: "users")
    }
    
    func createUserTable() {
        do {
            try dbService.db!.run(users.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(email, unique: true)
                t.column(firstName)
                t.column(lastName)
                t.column(password)
            })
        } catch {
            print("Error creating users table \(error)")
        }
    }
    
    func dropTable() {
        do {
            try dbService.db!.run(users.drop(ifExists: true))
            print("Dropped users table")
        } catch {
            print("Error dropping users table \(error)")
        }
    }
    
    func createUser() {
        do {
            let rowid = try dbService.db!.run(users.insert(or: .replace, email <- "johnsmith@mac.com", firstName <- "John", lastName <- "Smith", password <- "abc123"))
            print("inserted id: \(rowid)")
            
        } catch {
            print("Error saving to database \(error)")
        }
    }
    
    func getUsers() -> AnySequence<Row>? {
        do {
            return try dbService.db!.prepare(users)
        } catch {
            print("Error getting all users \(error)")
        }
        return nil
    }
    
    func getUser() -> User? {
        do {
            let query = users.select(users[*]).filter(email == "johnsmith@mac.com")
            let rows = try dbService.db!.prepare(query)
            for row in rows {
                return User(id: row[id], email: row[email], firstName: row[firstName], lastName: row[lastName], password: row[password])
            }
            
        } catch {
            print("Error preparing query \(error)")
        }
        return nil
    }
}
