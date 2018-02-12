//
//  SingUpViewController.swift
//  Flavr
//
//  Created by Ahmed on 12/3/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit
import SwifterSwift
import SwiftValidator
import SVProgressHUD

class SingUpViewController: UIViewController, ValidationDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var singInBtn: UIButton!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var nameErrorLabel: UILabel!

    let validator = Validator()
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (field, error) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
            }
            error.errorLabel?.text = error.errorMessage // works if you added labels
            error.errorLabel?.isHidden = false
            error.errorLabel?.textColor = UIColor.red
        }
    }
    
    func validationSuccessful() {
        // submit the form
        
        SVProgressHUD.show()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        RequestWrapper.Users.register(
            s_nickname: nameTextFiled.text!,
            s_email: emailTextFiled.text!,
            s_password: passwordTextFiled.text!) { (response, error) in
                SVProgressHUD.dismiss()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if (error != nil) {
                    // do something
                    return
                }
                
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "FlavrTabBarController")
                self.navigationController?.setViewControllers([vc], animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let BackImage = UIImage(named: "ic_arrow_back")
        self.navigationController?.navigationBar.backIndicatorImage = BackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = BackImage
        self.navigationController?.navigationBar.backItem?.title = " "
        self.navigationController?.navigationBar.hideBottomHairline()

      //  navigationController.
       // self.navigationController?.navigationBar.backItem.
//        validator.styleTransformers(success:{ (validationRule) -> Void in
//            print("here")
//            // clear error label
//            validationRule.errorLabel?.isHidden = true
//            validationRule.errorLabel?.text = ""
//            if let textField = validationRule.textField as? UITextField {
//                textField.layer.borderColor = UIColor.green.cgColor
//                textField.layer.borderWidth = 0.5
//
//            }
//        }, error:{ (validationError) -> Void in
//            print("error")
//            validationError.errorLabel?.isHidden = false
//            validationError.errorLabel?.text = validationError.errorMessage
//            if let textField = validationError.textField as? UITextField {
//                textField.layer.borderColor = UIColor.red.cgColor
//                textField.layer.borderWidth = 1.0
//            }
//        })
        validator.registerField(emailTextFiled,
                                errorLabel: emailErrorLabel,
                                rules: [RequiredRule(message: "Email Required"), EmailRule(message: "Invalid email")])
        
        validator.registerField(passwordTextFiled,
                                errorLabel: passwordErrorLabel,
                                rules: [RequiredRule(message: "Password Required"), PasswordRule(message: "Password must be 8 characters 1 uppercase letter")])
        
        validator.registerField(nameTextFiled,
                                errorLabel: nameErrorLabel,
                                rules: [RequiredRule(message: "Name Required")])
        
        #if DEBUG
        nameTextFiled.text = "test11"
        emailTextFiled.text = "test11@test.com"
        passwordTextFiled.text = "1qaz!QAZ"
        #endif
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
               //self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SingUpViewController.hideKeyboard)))
    }
    
    @IBAction func viewRootTapped(_ sender: Any) {
        self.view.endEditing(true)
    }

    @IBAction func singInBtnTapped(_ sender: Any) {
       emailErrorLabel?.isHidden = true
       passwordErrorLabel?.isHidden = true
       nameErrorLabel?.isHidden = true

        validator.validate(self)

    }
    
}
