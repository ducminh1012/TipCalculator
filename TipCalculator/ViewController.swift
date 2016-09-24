//
//  ViewController.swift
//  TipCalculator
//
//  Created by Kyou on 9/24/16.
//  Copyright © 2016 Kyou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Outlets
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var percentageSegment: UISegmentedControl!
    
    
    @IBOutlet weak var tipLabel: UILabel!
    
    
    @IBOutlet weak var moneyPerOneLabel: UILabel!
    
    
    @IBOutlet weak var moneyPerTwoLabel: UILabel!
    
    @IBOutlet weak var moneyPerThreeLabel: UILabel!
    
    @IBOutlet weak var moneyPerFourLabel: UILabel!
    
    let priceZero: NSNumber = 0
    let userDefault = UserDefaults()
    var percentage: Double = 0.0
    
    // Actions
    @IBAction func onMoneyTextFieldChange(_ sender: UITextField) {
        self.percentage = Double((self.percentageSegment.titleForSegment(at: self.percentageSegment.selectedSegmentIndex)?.replacingOccurrences(of: "%", with: ""))!)!
        
        guard (sender.text?.characters.count)! > 0 else {
            
            self.tipLabel.text = formatWithCurrency(price: priceZero)
            self.moneyPerOneLabel.text = formatWithCurrency(price: priceZero)
            self.moneyPerTwoLabel.text = formatWithCurrency(price: priceZero)
            self.moneyPerThreeLabel.text = formatWithCurrency(price: priceZero)
            self.moneyPerFourLabel.text = formatWithCurrency(price: priceZero)
            return
        }
        
        guard let price = Double(sender.text!) else {
            return
        }
        
        self.updateTipMoney(price: price)
        
    }
    
    @IBAction func onPercentageSegmentChange(_ sender: UISegmentedControl) {
        self.percentage = Double((self.percentageSegment.titleForSegment(at: self.percentageSegment.selectedSegmentIndex)?.replacingOccurrences(of: "%", with: ""))!)!
        
        guard let price = Double(self.moneyTextField.text!) else {
            return
        }
        
        self.updateTipMoney(price: price)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tipLabel.text = formatWithCurrency(price: priceZero)
        self.moneyPerOneLabel.text = formatWithCurrency(price: priceZero)
        self.moneyPerTwoLabel.text = formatWithCurrency(price: priceZero)
        self.moneyPerThreeLabel.text = formatWithCurrency(price: priceZero)
        self.moneyPerFourLabel.text = formatWithCurrency(price: priceZero)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        self.percentageSegment.setTitle("\(userDefault.double(forKey: "tip1"))%", forSegmentAt: 0)
        self.percentageSegment.setTitle("\(userDefault.double(forKey: "tip2"))%", forSegmentAt: 1)
        self.percentageSegment.setTitle("\(userDefault.double(forKey: "tip3"))%", forSegmentAt: 2)

        self.percentage = Double((self.percentageSegment.titleForSegment(at: self.percentageSegment.selectedSegmentIndex)?.replacingOccurrences(of: "%", with: ""))!)!
        
        guard let price = Double(self.moneyTextField.text!) else {
            return
        }
        
        self.updateTipMoney(price: price)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController {
    func formatWithCurrency(price: NSNumber) -> String{
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: price)!
    }
    
    func priceInNumber(price: Double) -> NSNumber{
        return NSNumber(value: price)
    }
    
    func updateTipMoney(price: Double){
        let tip = (price * self.percentage)/100
        
        let priceWithTip = price + (price * self.percentage)/100
        let priceWithTipPerTwo = priceWithTip/2
        let priceWithTipPerThree = priceWithTip/3
        let priceWithTipPerFour = priceWithTip/4
        
        let tipNumber = priceInNumber(price: tip)
        
        let priceWithTipNumber = priceInNumber(price: priceWithTip)
        let priceWithTipNumberTwo = priceInNumber(price: priceWithTipPerTwo)
        let priceWithTipNumberThree = priceInNumber(price: priceWithTipPerThree)
        let priceWithTipNumberFour = priceInNumber(price: priceWithTipPerFour)
        
        self.tipLabel.text = formatWithCurrency(price: tipNumber)
        
        self.moneyPerOneLabel.text = formatWithCurrency(price: priceWithTipNumber)
        self.moneyPerTwoLabel.text = formatWithCurrency(price: priceWithTipNumberTwo)
        self.moneyPerThreeLabel.text = formatWithCurrency(price: priceWithTipNumberThree)
        self.moneyPerFourLabel.text = formatWithCurrency(price: priceWithTipNumberFour)
    }
}

