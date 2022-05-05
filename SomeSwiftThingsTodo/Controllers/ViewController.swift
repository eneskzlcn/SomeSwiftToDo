//
//  ViewController.swift
//  SomeSwiftThingsTodo
//
//  Created by Nazif Enes Kızılcin on 1.05.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    var model = TodoModel()
    var chosenIndex : Int?
    
    @IBOutlet weak var tableView : UITableView!
    
    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
    
    func addTodo(task: String) {
        _ = self.model.add(task: task)
    }
    func removeTodo(task : String) {
        self.model.delete(task)
    }
    func completeTodo(at index: Int) {
        self.model.complete(self.model.todos[index].task)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    @IBAction func didDoneButtonTapped(_ sender: UIBarButtonItem) {
        if let chosenIndex = self.chosenIndex {
            self.completeTodo(at: chosenIndex)
            tableView.reloadData()
        }
        doneBarButtonItem.isEnabled = false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! TodoTableViewCell
        
        cell.taskLabel.text = model.todos[indexPath.row].task
        cell.statusLabel.text = model.todos[indexPath.row].status.rawValue
        cell.statusLabel.textColor = (model.todos[indexPath.row].status == .done) ? .green : .red
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.todos.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.chosenIndex = indexPath.row
        if model.todos[indexPath.row].status != .done {
            self.doneBarButtonItem.isEnabled = true
        }
        
    }
    
    @IBAction func didAddBarButtonItemTapped(_ sender : UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)

        
        let okeyAction = UIAlertAction(title: "Ok", style: .default) { _ in
            
            if let taskInput = (alertController.textFields?.first?.text), taskInput != "" {
                self.addTodo(task: taskInput)
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            alertController.dismiss(animated: true)
        }
        
        alertController.addTextField { textField in
                    textField.placeholder = "Enter a task to do..."
                }
        alertController.addAction(okeyAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}

