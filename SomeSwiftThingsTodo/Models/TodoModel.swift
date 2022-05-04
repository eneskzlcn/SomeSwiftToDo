//
//  TodoModel.swift
//  SomeSwiftThingsTodo
//
//  Created by Nazif Enes Kızılcin on 2.05.2022.
//

import Foundation


struct Todo {
    var task : String
    var status: String
    
    mutating func setStatus(_ status: String) {
        self.status = status
    }
}

struct TodoModel {
    var todos : [Todo] = [
        Todo(task: "Wake Up", status: "Todo"),
        Todo(task: "Breakfast", status: "Todo"),
        Todo(task: "Dinner", status: "Todo"),
        Todo(task: "Lunch", status: "Todo"),
        Todo(task: "Washing", status: "Done"),
        Todo(task: "Drink Tea", status: "Done"),
        Todo(task: "Sleep", status: "Done"),
    ]
    //Complete a task
    mutating func complete(_ task: String) {
        if let taskIndex = todos.firstIndex(where: {
            $0.task == task
        }) {
            self.todos[taskIndex].setStatus("Done")
        }
        
    }
    //Delete a task
    mutating func delete(_ task: String) {
        if let deleteIndex = todos.firstIndex(where:{
            $0.task == task
        }){
            self.todos.remove(at: deleteIndex)
        }
    }
    // Add a task
    mutating func add(task: String, status: String) -> Todo {
        let newTodo = Todo(task: task, status: status)
        self.todos.append(newTodo)
        return newTodo
    }
}
