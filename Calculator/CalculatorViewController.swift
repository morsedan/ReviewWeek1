//
//  ViewController.swift
//  Calculator
//
//  Created by Ben Gohlke on 5/29/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var brain = CalculatorBrain()
    var didCalculate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action Handlers
    
    @IBAction func operandTapped(_ sender: UIButton) {
        if didCalculate {
            clearTransaction()
        }
        
        guard let digit = sender.title(for: .normal) else { return }
        outputLabel.text = brain.addOperandDigit(digit)
        print(digit)
    }
    
    @IBAction func operatorTapped(_ sender: UIButton) {
        guard let thisOperator = sender.title(for: .normal) else { return }
        brain.setOperator(thisOperator)
        outputLabel.text = "0"
        didCalculate = false
    }
    
    @IBAction func equalTapped(_ sender: UIButton) {
        guard let answer = brain.calculateIfPossible() else {
            return
        }
        outputLabel.text = answer
        didCalculate = true
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        clearTransaction()
    }
    
    // MARK: - Private
    
    private func clearTransaction() {
        brain = CalculatorBrain()
        didCalculate = false
        outputLabel.text = "0"
    }
}
