//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 王跃 on 17/4/14.
//  Copyright © 2017年 cmcc. All rights reserved.
//

import Foundation

func changeSign(operand:Double) -> Double{
    return -operand
}

func multiply(operand:Double, operand2:Double) -> Double{
    return operand*operand2
}

struct  CalculatorBrain {

    private var accumulator: Double?
    
    private enum Operation{
       case constant(Double)
       case unaryOperaion((Double) -> Double)

    }
    
   
    
    private var operations:Dictionary<String,Operation> =
        [
            "π" : Operation.constant(Double.pi),//Double.pi,
            "e": Operation.constant(M_E),//M_E
            "√": Operation.unaryOperaion(sqrt),//sqrt
            "cos": Operation.unaryOperaion(cos),//cos
            "±" : Operation.unaryOperaion(changeSign),
//            "×" : Operation.binaryOperation(multiply),
//            "=": Operation.equals
        ]
    
    mutating func performOperation(_ symbol: String){
        if let operation = operations[symbol]{
            switch operation {
            case .constant(let value):
                accumulator = value;
            case .unaryOperaion(let function):
                if accumulator != nil {
                   accumulator = function(accumulator!)
                }
                break
            }
        }
    
       }
    
    mutating func setOperand(_ operand:Double){
         accumulator = operand
    }
    
    var result: Double?{
        get{
            return accumulator
        }
    }
}
