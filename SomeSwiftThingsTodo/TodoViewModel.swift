//
//  TodoViewModel.swift
//  SomeSwiftThingsTodo
//
//  Created by Nazif Enes Kızılcin on 8.05.2022.
//

import Foundation

class TodoViewModel {
    private var model: ObservableObject<TodoModel> = ObservableObject(TodoModel())
    
    init() {
        self.model.value = TodoModel()
    }
    
    func add(_ task: String) {
        _ = model.value.add(task: task)
    }
    func delete(_ task: String) {
        self.model.value.delete(task)
    }
    func complete(_ task: String) {
        self.model.value.complete(task)
    }
    func todo(at index: Int) -> Todo {
        self.model.value.todos[index]
    }
    func todoCount() -> Int {
        self.model.value.todos.count
    }
    func complete(at index: Int) {
        self.complete(self.model.value.todos[index].task)
    }
    func bindModel(_ listener: @escaping (TodoModel) -> Void) {
        self.model.bind(listener)
    }
}
