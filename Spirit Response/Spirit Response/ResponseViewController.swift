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
}
