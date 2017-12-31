//
//  ViewController.swift
//  UITextFieldValidator
//
//  Created by satyencareer@gmail.com on 12/31/2017.
//  Copyright (c) 2017 satyencareer@gmail.com. All rights reserved.
//

import UIKit
import UITextFieldValidator

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var myTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    @IBAction func submitAction(_ sender: Any) {
        Validator.shareInstance.textFieldValidator(textField: myTextField, emailTextField) { (textField:UITextField?, isSuccess) in
            if isSuccess {
                print("Validated.")
            }else{
                print("Not validated.")
            }
        }
    }
}

