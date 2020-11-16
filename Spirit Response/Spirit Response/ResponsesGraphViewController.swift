//
//  ResponsesGraphViewController.swift
//  Spirit Response
//
//  Created by Student on 11/16/20.
//

import UIKit

// ReactionsGraphViewController class to represent the graph
class ResponsesGraphViewController: UIViewController {
    var responses = Responses.shared
    
    /// Outlets for slider and label
    @IBOutlet weak var responseSlider:UISlider!
    @IBOutlet weak var responseCountLBL:UILabel!
    
    /// Method to draw the graph
    @IBAction func drawGraph(sender: UISlider){
        setData(sender: sender)
    }

}
