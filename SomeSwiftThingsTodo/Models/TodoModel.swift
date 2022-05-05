//
//  TodoModel.swift
//  SomeSwiftThingsTodo
//
//  Created by Nazif Enes Kızılcin on 2.05.2022.
//

import Foundation


enum TodoStatus : String {
    case todo = "Todo"
    case done = "Done"
}
struct Todo {
    var task : String
    var status: TodoStatus
    
    mutating func setStatus(_ status: TodoStatus) {
        self.status = status
    }
}

struct TodoModel {
    var todos : [Todo] = [
        Todo(task: "Wake Up", status: .todo),
        Todo(task: "Breakfast", status: .todo),
        Todo(task: "Dinner", status: .todo),
        Todo(task: "Lunch", status: .todo),
        Todo(task: "Washing", status: .done),
        Todo(task: "Drink Tea", status: .done),
        Todo(task: "Sleep", status: .done),
    ]
    //Complete a task
    mutating func complete(_ task: String) {
        if let taskIndex = todos.firstIndex(where: {
            $0.task == task
        }) {
            self.todos[taskIndex].setStatus(.done)
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
    mutating func add(task: String) -> Todo {
        let newTodo = Todo(task: task, status: .todo)
        self.todos.append(newTodo)
        return newTodo
    }
}
