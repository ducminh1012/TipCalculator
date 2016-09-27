//
//  SettingViewController.swift
//  TipCalculator
//
//  Created by Kyou on 9/24/16.
//  Copyright © 2016 Kyou. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var tipOneTextField: UITextField!
    @IBOutlet weak var tipTwoTextField: UITextField!

    @IBOutlet weak var tipThreeTextField: UITextField!
    
    
    // Actions
    @IBAction func onSaveTap(_ sender: UIButton) {
        
        userDefault.set(Double((self.tipOneTextField.text?.replacingOccurrences(of: "%", with: ""))!), forKey: "tip1")
        userDefault.set(Double((self.tipTwoTextField.text?.replacingOccurrences(of: "%", with: ""))!), forKey: "tip2")
        userDefault.set(Double((self.tipThreeTextField.text?.replacingOccurrences(of: "%", with: ""))!), forKey: "tip3")
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func onTipOneChange(_ sender: UITextField) {
        
        
    }
    
    @IBAction func onTipTwoChange(_ sender: UITextField) {
        
        
    }
    
    @IBAction func onTipThreeChange(_ sender: UITextField) {
        
    }
    
    var userDefault = UserDefaults.standard
    var tip1: Double?
    var tip2: Double?
    var tip3: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tipOneTextField.delegate = self
        tipTwoTextField.delegate = self
        tipThreeTextField.delegate = self
        
        print(userDefault.object(forKey: "tip1"))
        
        tipOneTextField.text = "\(tip1!)"
        tipTwoTextField.text = "\(tip2!)"
        tipThreeTextField.text = "\(tip3!)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tipOneTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension SettingViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if tipOneTextField.isFirstResponder {
            tipTwoTextField.resignFirstResponder()
            tipThreeTextField.resignFirstResponder()
        } else if tipTwoTextField.isFirstResponder{
            tipOneTextField.resignFirstResponder()
            tipThreeTextField.resignFirstResponder()
        }else{
            tipOneTextField.resignFirstResponder()
            tipTwoTextField.resignFirstResponder()
        }
    }
}
