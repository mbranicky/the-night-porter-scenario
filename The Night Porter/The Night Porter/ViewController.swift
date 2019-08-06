//
//  ViewController.swift
//  The Night Porter
//
//  Created by marek on 15/07/2019.
//  Copyright © 2019 Webby, s.r.o. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected a cell at row \(indexPath.row) from section \(indexPath.section)")
    }
    
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
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = dailyTasks[indexPath.row]
        case 1:
            cell.textLabel?.text = weeklyTasks[indexPath.row]
        case 2:
            cell.textLabel?.text = monthlyTasks[indexPath.row]
        default:
            cell.textLabel?.text = "This should not happen"
        }
        cell.imageView?.image = UIImage(named: "dice") // add an assset image into the image view of cell
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = "This is some detail"
        
        return cell
    }
    
    
    // Tasks sections as String[]
    let dailyTasks = [
        "Check all windows", "Check all doors", "Is the boiler fueled",
        "Check the mailbox", "Empty trash bins", "If freezing check the pipes",
        "Write down all 'suspicious' activities",
    ]
    
    let weeklyTasks = [
        "Flush all lavatories in cabins", "Check inside all cabins", "Walk the perimeter of property",
        "Clean the entrance windows", "Wash the main chanber floor"
    ]
    
    let monthlyTasks = [
        "Test smoke alarms", "Test motion detectors", "Test security alarm"
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

