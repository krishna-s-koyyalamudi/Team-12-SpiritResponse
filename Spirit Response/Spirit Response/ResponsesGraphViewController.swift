//
//  ResponsesGraphViewController.swift
//  Spirit Response
//
//  Created by Student on 11/16/20.
//

import UIKit

// ReactionsGraphViewController class to represent the graph
class ReactionsGraphViewController: UIViewController {
    var reactions = Responses.shared
    
    /// Outlets for slider and label
    @IBOutlet weak var reactionSlider:UISlider!
    @IBOutlet weak var reactionCountLBL:UILabel!
    
    /// Method to draw the graph
    @IBAction func drawGraph(sender: UISlider){
        setData(sender: sender)
    }

}
