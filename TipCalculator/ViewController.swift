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
    
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    
    @IBOutlet weak var moneyPerOneLabel: UILabel!
    
    
    @IBOutlet weak var moneyPerTwoLabel: UILabel!
    
    @IBOutlet weak var moneyPerThreeLabel: UILabel!
    
    @IBOutlet weak var moneyPerFourLabel: UILabel!
    
    let priceZero: NSNumber = 0
    let userDefault = UserDefaults.standard
    var percentage: Double = 0.0
    
    // Actions
    @IBAction func onMoneyTextFieldChange(_ sender: UITextField) {
        
//        UIView.animate(withDuration: 0.5) {
//            self.resultView.alpha = 1
//        }

        
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
        
        self.moneyTextField.resignFirstResponder()
        
        self.percentage = Double((self.percentageSegment.titleForSegment(at: self.percentageSegment.selectedSegmentIndex)?.replacingOccurrences(of: "%", with: ""))!)!
        
        guard let price = Double(self.moneyTextField.text!) else {
            return
        }
        
        self.updateTipMoney(price: price)
    }
    
    
    @IBAction func onSettingTap(_ sender: UIBarButtonItem) {
        
        let tip1 = Double((self.percentageSegment.titleForSegment(at: 0)?.replacingOccurrences(of: "%", with: ""))!)!
        let tip2 = Double((self.percentageSegment.titleForSegment(at: 1)?.replacingOccurrences(of: "%", with: ""))!)!
        let tip3 = Double((self.percentageSegment.titleForSegment(at: 2)?.replacingOccurrences(of: "%", with: ""))!)!
        
        userDefault.set(tip1, forKey: "tip1")
        userDefault.set(tip2, forKey: "tip2")
        userDefault.set(tip3, forKey: "tip3")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tipLabel.text = formatWithCurrency(price: priceZero)
        self.moneyPerOneLabel.text = formatWithCurrency(price: priceZero)
        self.moneyPerTwoLabel.text = formatWithCurrency(price: priceZero)
        self.moneyPerThreeLabel.text = formatWithCurrency(price: priceZero)
        self.moneyPerFourLabel.text = formatWithCurrency(price: priceZero)
        
        self.moneyTextField.delegate = self
//        self.resultView.alpha = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.moneyTextField.becomeFirstResponder()
        
        guard let tip1: Double = userDefault.object(forKey: "tip1") as! Double? else { return }
        guard let tip2: Double = userDefault.object(forKey: "tip2") as! Double? else { return }
        guard let tip3: Double = userDefault.object(forKey: "tip3") as! Double? else { return }
        
        self.percentageSegment.setTitle("\(tip1)%", forSegmentAt: 0)
        self.percentageSegment.setTitle("\(tip2)%", forSegmentAt: 1)
        self.percentageSegment.setTitle("\(tip3)%", forSegmentAt: 2)

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingVC = segue.destination as! SettingViewController
        
        let tip1 = Double((self.percentageSegment.titleForSegment(at: 0)?.replacingOccurrences(of: "%", with: ""))!)!
        let tip2 = Double((self.percentageSegment.titleForSegment(at: 1)?.replacingOccurrences(of: "%", with: ""))!)!
        let tip3 = Double((self.percentageSegment.titleForSegment(at: 2)?.replacingOccurrences(of: "%", with: ""))!)!
        
        settingVC.tip1 = tip1
        settingVC.tip2 = tip2
        settingVC.tip3 = tip3
    }


}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let array = Array(textField.text!.characters)
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            return true
        case ".":
            
            var decimalCount = 0
            for character in array {
                if character == "." {
                    decimalCount += 1
                }
            }
            
            if decimalCount == 1 {
                return false
            } else {
                return true
            }
        default:
            let array = Array(string.characters)
            if array.count == 0 {
                return true
            }
            return false
        }
    }
    
}

// Utils
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

