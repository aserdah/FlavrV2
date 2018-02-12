//
//  LogInViewController.swift
//  Flavr
//
//  Created by Ahmed on 12/3/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit
import SwifterSwift
import SwiftValidator
import UINavigationBar_Addition
import SVProgressHUD

class LogInViewController: UIViewController,  ValidationDelegate, UITextFieldDelegate{
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
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
        
        SVProgressHUD.show()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        RequestWrapper.Users.login(
            s_email: emailTextFiled.text!,
            s_password: passwordTextFiled.text!) { (response, error) in
                SVProgressHUD.dismiss()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if (error != nil) {
                    // do something
                    let message = error?.errorModel?.status.message ?? "Error Message"
                    let alert = UIAlertController.init(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "SearchViewController")
//                self.navigationController?.setViewControllers([vc], animated: true)
                self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let BackImage = UIImage(named: "ic_arrow_back")
        self.navigationController?.navigationBar.backIndicatorImage = BackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = BackImage
        self.navigationController?.navigationBar.hideBottomHairline()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.backBarButtonItem?.title = " "
        
        validator.registerField(emailTextFiled, errorLabel: emailErrorLabel, rules: [RequiredRule(message: "Email Required"), EmailRule(message: "Invalid email")])
        
        validator.registerField(passwordTextFiled, errorLabel: passwordErrorLabel, rules: [RequiredRule(message: "Password Required"), PasswordRule(message: "Password must be 8 characters 1 uppercase letter")])
 
        #if DEBUG
            emailTextFiled.text = "test11@test.com"
            passwordTextFiled.text = "1qaz!QAZ"
        #endif
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.backBarButtonItem?.title = " "

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewRootTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func logInBtnTapped(_ sender: Any) {
        emailErrorLabel?.isHidden = true
        passwordErrorLabel?.isHidden = true
        validator.validate(self)

    }
    
    @IBAction func forgetPasswordTapped(_ sender: Any) {
    }
}
