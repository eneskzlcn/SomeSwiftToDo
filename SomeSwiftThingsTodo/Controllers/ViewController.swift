//
//  ViewController.swift
//  SomeSwiftThingsTodo
//
//  Created by Nazif Enes Kızılcin on 1.05.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    var model = TodoModel()
    
    @IBOutlet weak var tableView : UITableView!
    
    func addTodo(task: String, status: String) {
        _ = self.model.add(task: task, status: status)
    }
    func removeTodo(task : String) {
        self.model.delete(task)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! TodoTableViewCell
        
        cell.taskLabel.text = model.todos[indexPath.row].task
        cell.statusLabel.text = model.todos[indexPath.row].status
        cell.statusLabel.textColor = (model.todos[indexPath.row].status == "Done") ? .green : .red
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.todos.count
    }
    

}

