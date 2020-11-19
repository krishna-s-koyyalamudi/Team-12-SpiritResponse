//
//  SpiritCalculatorViewController.swift
//  Spirit Response
//
//  Created by Student on 11/16/20.
//

import UIKit

/// SpiritCalculatorViewController class for the calculator view
class SpiritCalculatorViewController: UIViewController {

    ///Variables to change the Text Fields to Doubles
    private var weight:Double = 0.0
    private var beer:Double = 0.0
    private var wine:Double = 0.0
    private var liquor:Double = 0.0
    private var hours:Double = 0.0
    private var minutes:Double = 0.0
    private var numResult:String = ""
    
    ///Variables for calculations
    private var eliminationRate = 0.00017
    private var timeConsuming:Double = 0.0
    private var gender:Double = 0.0
    private var bac:Double = 0.0
    
    /// All text fields to collect data for BAC
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var beerTF: UITextField!
    @IBOutlet weak var wineTF: UITextField!
    @IBOutlet weak var liquorTF: UITextField!
    @IBOutlet weak var hoursTF: UITextField!
    @IBOutlet weak var minutesTF: UITextField!
    @IBOutlet weak var resultTF: UITextField!
    
    @IBOutlet weak var maleLBL:UILabel!
    @IBOutlet weak var femaleLBL:UILabel!
    
    @IBOutlet weak var maleBTN:UIButton!
    @IBOutlet weak var femaleBTN:UIButton!
    
    ///Button for Male Icon
    @IBAction func maleButton(sender: UIButton){
        maleLBL?.backgroundColor = UIColor.lightGray
        maleBTN.backgroundColor = UIColor.lightGray
        femaleLBL?.backgroundColor = UIColor.white
        femaleBTN.backgroundColor = UIColor.white
        gender = 0.73
    }
    
    ///Button for Female Icon
    @IBAction func femaleButton(sender: UIButton){
        maleLBL?.backgroundColor = UIColor.white
        maleBTN.backgroundColor = UIColor.white
        femaleLBL?.backgroundColor = UIColor.lightGray
        femaleBTN.backgroundColor = UIColor.lightGray
        gender = 0.66
    }
    
    /// viewDidLoad() method
    override func viewDidLoad() {
        super.viewDidLoad()
        maleLBL?.backgroundColor = UIColor.white
        maleBTN.backgroundColor = UIColor.white
        femaleLBL?.backgroundColor = UIColor.white
        femaleBTN.backgroundColor = UIColor.white
    }
    
    /// calculate to calculate the BAC
    /// - Parameter sender: UIButton
    @IBAction func calculate(sender: Any){
        if gender == 0.0 {
            displayAlert(title: "Insufficient Input", message: "Please select Gender")
        } else if Double(beerTF.text!) == nil{
            displayAlert(title: "Invalid Input", message: "Provide a numeric value in Beer field")
        } else if Double(wineTF.text!) == nil {
            displayAlert(title: "Invalid Input", message: "Provide a numeric value in Wine field")
        } else if Double(liquorTF.text!) == nil {
            displayAlert(title: "Invalid Input", message: "Provide a numeric value in Liquor field")
        } else if Int(hoursTF.text!) == nil {
            displayAlert(title: "Invalid Input", message: "Provide a valid number for hours in Time field")
        } else if Int(minutesTF.text!) == nil {
            displayAlert(title: "Invalid Input", message: "Provide a valid number for minutes in Time field")
        } else if Int(minutesTF.text!)! > 60 {
            displayAlert(title: "Invalid Input", message: "minutes should not be greater than 60")
        }else {
            beer = Double(beerTF.text!)!
            wine = Double(wineTF.text!)!
            liquor = Double(liquorTF.text!)!
            timeConsuming = Double(hoursTF.text!)! + (Double(minutesTF.text!)! / 60.00 )
            weight = Double(weightTF.text!)!
            let volumeOfAlocohal = (beer * 0.05 * 12) + (wine * 0.12 * 5) + (liquor * 0.4 * 1.5)
            print(volumeOfAlocohal)
            print(weight)
            print(gender)
            print(timeConsuming)
            if weight > 0 {
                bac = ((volumeOfAlocohal) * (5.14 / weight) * gender) - (0.015 * timeConsuming)
                bac = bac > 0 ? bac : 0
            }
            resultTF.text = String(format:"%.2f", bac)
        }
        
    }
    
    /// clear to reset all fields
    /// - Parameter sender: UIButton
    @IBAction func clear(sender: Any){
        weightTF.text = "0"
        beerTF.text = "0"
        wineTF.text = "0"
        liquorTF.text = "0"
        hoursTF.text = "0"
        minutesTF.text = "0"
        resultTF.text = "0"
        gender = 0.0
        maleLBL?.backgroundColor = UIColor.white
        maleBTN.backgroundColor = UIColor.white
        femaleLBL?.backgroundColor = UIColor.white
        femaleBTN.backgroundColor = UIColor.white
    }
    
    /// Display Alert window
    /// - Parameters:
    ///   - title: title for alert
    ///   - message: message for alert
    func displayAlert(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(action)
        self.present(ac, animated: true, completion: nil)
    }
    
}
