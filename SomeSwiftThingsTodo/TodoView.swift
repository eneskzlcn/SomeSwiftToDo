//
//  ViewController.swift
//  SomeSwiftThingsTodo
//
//  Created by Nazif Enes Kızılcin on 1.05.2022.
//

import UIKit
import Foundation
import CoreLocation

class TodoView: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var chosenIndex : Int?
    private let todoViewModel = TodoViewModel()

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        todoViewModel.bindModel { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    @IBAction func didDoneButtonTapped(_ sender: UIBarButtonItem) {
        if let chosenIndex = self.chosenIndex {
            todoViewModel.complete(at: chosenIndex)
        }
        doneBarButtonItem.isEnabled = false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! TodoTableViewCell

        cell.taskLabel.text = todoViewModel.todo(at: indexPath.row).task
        cell.statusLabel.text = todoViewModel.todo(at: indexPath.row).status.rawValue
        cell.statusLabel.textColor = (todoViewModel.todo(at: indexPath.row).status == .done) ? .green : .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoViewModel.todoCount()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.chosenIndex = indexPath.row
        if todoViewModel.todo(at: indexPath.row).status != .done {
            self.doneBarButtonItem.isEnabled = true
        }
        
    }

    @IBAction func didAddBarButtonItemTapped(_ sender : UIBarButtonItem) {
        let alertController = createAddTaskAlert()
        self.present(alertController, animated: true)
    }
    
    func createAddTaskAlert() -> UIAlertController {
        typealias Constants = UIConstants.AddAlert
        let alertController = UIAlertController(title: Constants.title, message: nil, preferredStyle: Constants.style)

        let confirmAction = confirmAction(controller: alertController,title: Constants.ConfirmAction.title,style: Constants.ConfirmAction.style)
        let cancelAction = UIAlertAction(title: Constants.CancelAction.title, style: Constants.CancelAction.style) { _ in
            alertController.dismiss(animated: true)
        }
        alertController.addTextField { textField in
            textField.placeholder = Constants.inputPlaceholder
                }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        return alertController
    }
    
    func confirmAction(controller: UIAlertController,title: String, style: UIAlertAction.Style) -> UIAlertAction {
        UIAlertAction(title: title, style: style) { _ in
            if let task = (controller.textFields?.first?.text), task != "" {
                self.todoViewModel.add(task)
            }else {
                let warningAlertController = self.warningAlert()
                self.present(warningAlertController, animated: true)
            }
        }
    }
    
    func warningAlert() -> UIAlertController {
        typealias Constants = UIConstants.WarningAlert
        
        let warningAlertController = UIAlertController(title: Constants.title, message: Constants.message, preferredStyle: Constants.style)
        let closeAction = UIAlertAction(title: Constants.CloseAction.title, style: Constants.CloseAction.style) { _ in
            warningAlertController.dismiss(animated: true)
        }
        warningAlertController.addAction(closeAction)
        return warningAlertController
    }
    
    struct UIConstants {
        struct WarningAlert {
            static var title = "Warning"
            static var message = "You can not leave the task field empty."
            static var style = UIAlertController.Style.alert
            
            struct CloseAction {
                static var title = "Ok"
                static var style = UIAlertAction.Style.default
            }
        }
        struct AddAlert {
            static var title = "Add"
            static var style = UIAlertController.Style.alert
            static var inputPlaceholder = "Enter a task to do..."
            struct ConfirmAction {
                static var title = "Ok"
                static var style = UIAlertAction.Style.default
            }
            struct CancelAction {
                static var title = "Cancel"
                static var style = UIAlertAction.Style.cancel
            }
            
        }
        
    }
}

