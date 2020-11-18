//
//  ResponseViewController.swift
//  Spirit Response
//
//  Created by Student on 11/16/20.
//

import UIKit
import Parse

/// ResponseViewController class for home page
class ResponseViewController: UIViewController {
    var startTime = "startTime"
    var endTime = "endTime"
    var responses = Responses.shared
    
    /// blinking button to display at random positions
    @IBOutlet weak var blinkingButton:UIButton!
    /// view for the blinking button
    @IBOutlet weak var responseAreaView: UIView!
    
    /// viewDidLoad() method
    override func viewDidLoad() {
        super.viewDidLoad()
        blinkingButton.isHidden = true
        navigationItem.title = "Try How Fast you React!"
    }
    /// startBtn to start to display the blinking button to start calculate response
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
    /// responseBtn to relocate the blinking button when clicked
    /// - Parameter sender: UIButton
    @IBAction func responseBTN(_ sender: Any) {
        let dateTime = Date()
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss +SSSS"
        endTime = formatter.string(from: dateTime as Date)
        
        responses.addResponse(startTime: startTime, endTime: endTime)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"Added Response"), object: nil)
        startTime = endTime
        
        // Find the blinkingButton's width and height
        let blinkingButtonWidth = blinkingButton.frame.width
        let blinkingButtonHeight = blinkingButton.frame.height
        
        // Find the width and height of the enclosing view
        let currentViewWidth = blinkingButton.superview!.bounds.width
        let currentViewHeight = blinkingButton.superview!.bounds.height
        
        // Compute width and height of the area to contain the button's center
        let newWidth = currentViewWidth - blinkingButtonWidth
        let newHeight = currentViewHeight - blinkingButtonHeight
        
        // offset values
        let xoffset = CGFloat(arc4random_uniform(UInt32(newWidth)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(newHeight)))
        
        // Offset the button's center by the random offsets.
        blinkingButton.center.x = xoffset + blinkingButtonWidth / 2
        blinkingButton.center.y = yoffset + blinkingButtonHeight / 2
    }
}
