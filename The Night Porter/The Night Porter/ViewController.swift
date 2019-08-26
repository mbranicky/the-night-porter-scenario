//
//  ViewController.swift
//  The Night Porter
//
//  Created by marek on 15/07/2019.
//  Copyright © 2019 Webby, s.r.o. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // outlet reference to tasks table view
    @IBOutlet weak var tasksTableView: UITableView!
    
    // Table View Delegate methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected a cell at row \(indexPath.row) from section \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // create an action for swipe configuration
        // 'handler' parameter is an anonymouse function, or lambda as in Java
        let completeAction = UIContextualAction(style: .normal, title: "Complete", handler: { (action: UIContextualAction, source: UIView, actionPerformed: (Bool) -> Void) in
            
            // find the right object and mark it as completed
            switch indexPath.section {
                case 0:
                    self.dailyTasks[indexPath.row].completed = true
                case 1:
                    self.weeklyTasks[indexPath.row].completed = true
                case 2:
                    self.monthlyTasks[indexPath.row].completed = true
                default:
                    break
            }
            tableView.reloadData() // to update tasks visually
            
            actionPerformed(true) // to let the iOS know the action was completed
        })
        
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    // Table View Datasource methods
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
                return "Daily Tasks"
            case 1:
                return "Weekly Tasks"
            case 2:
                return "Monthly Tasks"
            default:
                return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // set the table view transparent background
        tableView.backgroundColor = UIColor.clear
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return dailyTasks.count
            case 1:
                return weeklyTasks.count
            case 2:
                return monthlyTasks.count
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // this is a way how to re-use existing instances of table cells and don't create a new ones for every
        // item, even those which are out of user view
        // for identifier see the design view -> properties of table cell prototype
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCellStyle", for: indexPath)
        
        var currentTask: Task!
        
        switch indexPath.section {
            case 0:
                currentTask = dailyTasks[indexPath.row]
            case 1:
                currentTask = weeklyTasks[indexPath.row]
            case 2:
                currentTask = monthlyTasks[indexPath.row]
            default:
                break
        }
        
        // set the cell text content
        cell.textLabel?.text = currentTask.name
        
        // determine the cell text color based on task state
        if currentTask.completed {
            cell.textLabel?.textColor = UIColor.lightGray
            cell.accessoryType = .checkmark
        } else {
             cell.textLabel?.textColor = UIColor.black
            cell.accessoryType = .disclosureIndicator
        }
        
        cell.imageView?.image = UIImage(named: "taskIcon") // add an assset image into the image view of cell
        
        cell.detailTextLabel?.text = "This is some detail"
        
        // set the cell transparent background
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    // Tasks data sections as Task[]
    
    var dailyTasks = [
        Task(name: "Check all windows", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Check all doors", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Is the boiler fueled", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Check the mailbox", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Empty trash bins", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "If freezing check the pipes", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Write down all 'suspicious' activities", type: .daily, completed: false, lastCompleted: nil)
    ]
   
    var weeklyTasks = [
        Task(name: "Flush all lavatories in cabins", type: .weekly, completed: false, lastCompleted: nil),
        Task(name: "Check inside all cabins", type: .weekly, completed: false, lastCompleted: nil),
        Task(name: "Walk the perimeter of property", type: .weekly, completed: false, lastCompleted: nil),
        Task(name: "Clean the entrance windows", type: .weekly, completed: false, lastCompleted: nil),
        Task(name: "Wash the main chamber floor", type: .weekly, completed: false, lastCompleted: nil)
    ]

    var monthlyTasks = [
        Task(name: "Test smoke alarms", type: .monthly, completed: false, lastCompleted: nil),
        Task(name: "Test motion detectors", type: .monthly, completed: false, lastCompleted: nil),
        Task(name: "Test security alarm", type: .monthly, completed: false, lastCompleted: nil)
    ]
    
    
    @IBAction func resetTasks(_ sender: Any) {
        // create a confirmation dialog
        let confirm = UIAlertController(title: "Are you sure?", message: "Really want to reset the tasks?", preferredStyle: .alert)
        
        // create YES action
        let yes = UIAlertAction(title: "Yes", style: .destructive) { action in
            // iterate the static list of tasks and reset the completed property
            for i in 0..<self.dailyTasks.count {
                self.dailyTasks[i].completed = false
            }
            
            for i in 0..<self.weeklyTasks.count {
                self.weeklyTasks[i].completed = false
            }
            
            for i in 0..<self.monthlyTasks.count {
                self.monthlyTasks[i].completed = false
            }
            
            // tell the table to reload data
            self.tasksTableView.reloadData()
        }
        // create NO action
        let no = UIAlertAction(title: "No", style: .cancel) { action in
            print("That was a close one!")
        }
        // add actions to confirm controller
        confirm.addAction(yes)
        confirm.addAction(no)
        
        // show it
        present(confirm, animated: true, completion: nil)
    }
    
    // action for dark mode switch
    @IBAction func toggleDarkMode(_ sender: Any) {
        let mySwitch = sender as! UISwitch
        if mySwitch.isOn {
            view.backgroundColor = UIColor.darkGray
        } else {
            view.backgroundColor = UIColor.white
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

