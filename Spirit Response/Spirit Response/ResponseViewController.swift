//
//  ResponseViewController.swift
//  Spirit Response
//
//  Created by Student on 11/16/20.
//

import UIKit

/// ReactionViewController class for home page
class ResponseViewController: UIViewController {
    var startTime = "startTime"
    var endTime = "endTime"
    var reactions = Responses.shared
    
    /// blinking button to display at random positions
    @IBOutlet weak var blinkingButton:UIButton!
    /// view for the blinking button
    @IBOutlet weak var reactionAreaView: UIView!
    
    /// viewDidLoad() method
    override func viewDidLoad() {
        super.viewDidLoad()
        blinkingButton.isHidden = true
        navigationItem.title = "Try How Fast you React!"
    }
    /// startBtn to start to display the blinking button to start calculate reaction
    /// - Parameter sender: UIButton
    @IBAction func startBtn(_ sender: Any) {
        blinkingButton.isHidden = false
        
        let dateTime = Date()
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss +SSSS"
        startTime = formatter.string(from: dateTime as Date)
    }
    /// stopBtn for stopping the blinking button action
    /// - Parameter sender: UIButton
    @IBAction func stopBtn(_ sender: Any) {
        blinkingButton.isHidden = true
    }
}
