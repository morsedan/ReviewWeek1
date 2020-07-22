//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Ben Gohlke on 5/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

enum OperatorType: String {
    case addition = "+"
    case subtraction = "−"
    case multiplication = "×"
    case division = "÷"
}

class CalculatorBrain {
    var operand1String = ""
    var operand2String = ""
    var operatorType: OperatorType?
    var didCalculate = false
    
    func addOperandDigit(_ digit: String) -> String {
        
        if operatorType == nil {
            if operand1String.contains(".") && digit == "." { return operand1String }
            if digit == "." && operand1String.isEmpty { operand1String.append("0")}
            if digit == "+/-" {
                guard let operand1Double = Double(operand1String) else {
                    operand1String.append("-")
                    return "-0"}
                operand1String = String(operand1Double * -1.0)
                operand1String = formatAnswerString(from: operand1String)
                return operand1String
            }
            operand1String.append(digit)
            return operand1String
        } else {
            if operand2String.contains(".") && digit == "." { return operand2String }
            if digit == "." && operand2String.isEmpty { operand2String.append("0") }
            operand2String.append(digit)
            return operand2String
        }
    }
    
    func setOperator(_ operatorString: String) {
        switch operatorString {
        case "+": operatorType = .addition
        case "−": operatorType = .subtraction
        case "×": operatorType = .multiplication
        default: operatorType = .division
        }
    }
    
    func calculateIfPossible() -> String? {
        guard let operatorType = operatorType,
            let operand1 = Double(operand1String),
            let operand2 = Double(operand2String) else { return nil }
        switch operatorType {
        case .addition: operand1String = String(operand1 + operand2)
        case .subtraction: operand1String = String(operand1 - operand2)
        case .multiplication: operand1String = String(operand1 * operand2)
        case .division: operand1String = String(operand1 / operand2)
        }
        self.operatorType = nil
        operand2String = ""
        operand1String = formatAnswerString(from: operand1String)
        return operand1String
    }
    
    func formatAnswerString(from numberString: String) -> String {
        guard Double(numberString) != nil else { return numberString }
        if Double(numberString)?.rounded() == Double(numberString) {
            return "\(Int(Double(numberString)!))"
        }
        return numberString
    }
}
