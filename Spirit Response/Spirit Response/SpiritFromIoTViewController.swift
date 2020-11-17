//
//  SpiritFromloTViewController.swift
//  Spirit Response
//
//  Created by Student on 11/16/20.
//

import UIKit

/// SpiritFromIoTViewController class for IoT values tab
class SpiritFromIoTViewController: UIViewController {

    /// rateLBL for the rate of BAC
    @IBOutlet weak var rateLBL:UILabel!
    
    /// stageLBL for the drinking stage
    @IBOutlet weak var stageLBL:UILabel!
    
    /// recordedAtLBL for the date and time recorded
    @IBOutlet weak var recordedAtLBL:UILabel!
    
    /// getSpirit for the getting Spirit value from some API
    /// - Parameter sender: UIButton
    @IBAction func getSpirit(sender: Any){
        
        let rate = 10.45
        let stage = "Sobriety"
        let recordedAt = "Fri 10:16 PM"
        rateLBL.text = String(rate)
        stageLBL.text = stage
        recordedAtLBL.text = recordedAt
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Spirit from IoT"
    }
    
}
