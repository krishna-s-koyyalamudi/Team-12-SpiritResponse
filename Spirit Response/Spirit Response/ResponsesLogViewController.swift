//
//  ResponsesLogViewController.swift
//  Spirit Response
//
//  Created by Student on 11/16/20.
//

import UIKit
import Parse

/// ResponsesLogViewController to represent the responses log
class ResponsesLogViewController: UITableViewController {
    
    // Stored properties for response times and response dates
    var responseTimes:[Double] = []
    var responseDays:[String] = []
    var responses = Responses.shared
    
    /// viewDidLoad() method
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Responses Log (Milliseconds and Day)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear Log", style: .plain, target: self, action: #selector(displayInfo(sender:)))
        NotificationCenter.default.addObserver(self, selector: #selector(responseAdded(notification:)), name: NSNotification.Name(rawValue:"Added Response"), object: nil)
    }
    
    /// Method to add the response and reload data
    @objc func responseAdded(notification:Notification){
        tableView.reloadData()
    }
    
    /// Method for clear function in the log
    @objc
    func displayInfo(sender:Any){
        responses.clearResponse()
        tableView.reloadData()
        let ac = UIAlertController(title: "Cleared", message: "Log has been cleared", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(action)
        present(ac, animated: true, completion: nil)
    }
    
    /// Returns the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Returns the number of responses by taking number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.numResponses()
    }
    
    /// static values for the identifying the labels in table view
    let timeLBLTag = 100
    let dayLBLTag = 200
    
    /// To store and display the final values
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bac", for: indexPath)
        if responses[indexPath.row] != nil {
            let timeLBL = cell.viewWithTag(timeLBLTag) as! UILabel
            let dayLBL = cell.viewWithTag(dayLBLTag) as! UILabel
            timeLBL.text = String(responses.getResponseTime(indes: indexPath.row))
            dayLBL.text = responses.getDay(index: indexPath.row)
        }
        return cell
    }
    
    
}
