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
       case binaryOperation((Double, Double) -> Double)
       case equals
    }
    
   
    
    private var operations:Dictionary<String,Operation> =
        [
            "π" : Operation.constant(Double.pi),//Double.pi,
            "e": Operation.constant(M_E),//M_E
            "√": Operation.unaryOperaion(sqrt),//sqrt
            "cos": Operation.unaryOperaion(cos),//cos
            "±" : Operation.unaryOperaion({-$0}),
            "×" : Operation.binaryOperation({$0 * $1}),
            "÷" : Operation.binaryOperation({$0 / $1}),
            "+" : Operation.binaryOperation({$0 + $1}),
            "−" : Operation.binaryOperation({$0 - $1}),
            "=": Operation.equals
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
            case .binaryOperation(let function):
                if accumulator != nil {
                     pendingBinaryOperation = PendingBinaryOperation(function:function, firstOperand:accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    
       }
    
    private mutating func performPendingBinaryOperation(){
        if pendingBinaryOperation != nil && accumulator != nil{
         accumulator = pendingBinaryOperation!.perform(with: accumulator!)
         pendingBinaryOperation = nil
        }
     
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    struct PendingBinaryOperation {
        let function: (Double,Double) ->Double
        let firstOperand:Double
        func perform (with secondPerand:Double) -> Double{
         return function(firstOperand, secondPerand)
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
