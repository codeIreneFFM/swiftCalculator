//
//  ViewController.swift
//  Calculator
//
//  Created by 王跃 on 17/4/14.
//  Copyright © 2017年 cmcc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!  //= nil not set = optional
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
       // drawHorizontalLine(from: 5.0, to: 8.5, using: UIColor.blue)
        let digit = sender.currentTitle!
        print("\(digit) was touched")
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
      
    }
    
    var displayValue: Double{
        get {
           return Double(display.text!)!
        }
        set{
           display.text = String(newValue)
        
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func perfomOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
      
        if let mathematicalSybol = sender.currentTitle {
         brain.performOperation(mathematicalSybol)
        }
        if let result = brain.result{
           displayValue = result
        }
        
    }
//    func drawHorizontalLine(from startX:Double, to endX:Double, using color:UIColor){
//    
//    }
}

