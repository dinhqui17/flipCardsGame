//
//  SignupScreenViewController.swift
//  Conceptcube Test App
//
//  Created by Dinh Quy on 2/2/22.
//  Copyright © 2022 Dinh Quy. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupScreenViewController: UIViewController {
    
    @IBOutlet weak var signupHeadingLabel: UILabel!
    @IBOutlet weak var signupTopImage: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var checkEmailButton: UIButton!
    @IBOutlet weak var emailCheckStatus: UILabel!
    @IBOutlet weak var emailIconStatus: UIImageView!
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insetsLayoutMarginsFromSafeArea = false
        setupUI()
        dataPicker()
    }
    
    func setupUI() {
        
        signupHeadingLabel.text = K.Labels.signupLabel.uppercased()
        signupHeadingLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        signupHeadingLabel.textColor = K.Colors.primaryColor
        
        signupTopImage.image = K.Images.loginTopImage
        signupTopImage.contentMode = UIView.ContentMode.scaleToFill
        
        emailCheckStatus.text = ""
        emailCheckStatus.font = emailCheckStatus.font.withSize(12.0)
        emailCheckStatus.textColor = K.Colors.primaryColor
        
        emailField.backgroundColor = K.Colors.fieldBackgroundColor
        emailField.layer.cornerRadius = 15.0
        emailField.layer.borderWidth = 1.0
        emailField.layer.borderColor = K.Colors.fieldBorderColor
        emailField.layer.masksToBounds = true
        emailField.withImage(direction: .Left, iconName: K.Icons.emailFieldIcon)
        
        checkEmailButton.backgroundColor = K.Colors.primaryColor
        checkEmailButton.setTitleColor(K.Colors.buttonTextActiveColor, for: .normal)
        checkEmailButton.setTitle(K.Labels.checkLabel, for: .normal)
        checkEmailButton.layer.cornerRadius = 15.0
        
        passwordField.backgroundColor = K.Colors.fieldBackgroundColor
        passwordField.layer.cornerRadius = 15.0
        passwordField.layer.borderWidth = 1.0
        passwordField.layer.borderColor = K.Colors.fieldBorderColor
        passwordField.layer.masksToBounds = true
        passwordField.withImage(direction: .Left, iconName: K.Icons.passwordFieldIcon)
        
        
        confirmPasswordField.backgroundColor = K.Colors.fieldBackgroundColor
        confirmPasswordField.layer.cornerRadius = 15.0
        confirmPasswordField.layer.borderWidth = 1.0
        confirmPasswordField.layer.borderColor = K.Colors.fieldBorderColor
        confirmPasswordField.layer.masksToBounds = true
        confirmPasswordField.withImage(direction: .Left, iconName: K.Icons.passwordFieldIcon)
        
        idField.backgroundColor = K.Colors.fieldBackgroundColor
        idField.layer.cornerRadius = 15.0
        idField.layer.borderWidth = 1.0
        idField.layer.borderColor = K.Colors.fieldBorderColor
        idField.layer.masksToBounds = true
        idField.withImage(direction: .Left, iconName: K.Icons.usernameFieldIcon)
        
        birthdayField.backgroundColor = K.Colors.fieldBackgroundColor
        birthdayField.layer.cornerRadius = 15.0
        birthdayField.layer.borderWidth = 1.0
        birthdayField.layer.borderColor = K.Colors.fieldBorderColor
        birthdayField.layer.masksToBounds = true
        birthdayField.withImage(direction: .Left, iconName: K.Icons.birthdayFieldIcon)
        
        
        backButton.backgroundColor = K.Colors.secondaryColor
        backButton.setTitleColor(K.Colors.buttonSecondaryTextColor, for: .normal)
        backButton.setTitle(K.Labels.backLabel.uppercased(), for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        backButton.layer.cornerRadius = 15.0
        
        joinButton.backgroundColor = K.Colors.primaryColor
        joinButton.setTitleColor(K.Colors.buttonTextActiveColor, for: .normal)
        joinButton.setTitle(K.Labels.joinLabel.uppercased(), for: .normal)
        joinButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        joinButton.layer.cornerRadius = 15.0
        
    }
    
    func dataPicker() {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(SignupScreenViewController.dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignupScreenViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        birthdayField.inputView = datePicker
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
        
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        birthdayField.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    @IBAction func checkEmailExist(_ sender: UIButton) {
        
        guard let email = emailField.text, !email.isEmpty else {
            showAlert(title: K.Response.error, message: K.Response.missingEmail)
            return
        }
        
        FirebaseAuth.Auth.auth().fetchSignInMethods(forEmail: email, completion: { (notification, error) in
            if let error = error {
                self.emailCheckStatus.text = error.localizedDescription
                self.emailCheckStatus.textColor = K.Colors.errorColor
                self.emailIconStatus.image = UIImage(named: K.Icons.emailNotAvailable)
            } else if let notification = notification {
                switch notification {
                case ["password"]:
                    self.emailCheckStatus.text = K.Response.emailAlready
                    self.emailCheckStatus.textColor = K.Colors.errorColor
                    self.emailIconStatus.image = UIImage(named: K.Icons.emailNotAvailable)
                default:
                    return
                }
                
            } else {
                self.emailCheckStatus.text = K.Response.emailAvailable
                self.emailCheckStatus.textColor = K.Colors.validColor
                self.emailIconStatus.image = UIImage(named: K.Icons.emailAvailable)
            }
        }
        )
        
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func joinPressed(_ sender: UIButton) {
        
        guard let id = idField.text, !id.isEmpty,
            let password = passwordField.text, !password.isEmpty,
            let email = emailField.text, !email.isEmpty,
            let birthday = birthdayField.text, !birthday.isEmpty else {
                
                showAlert(title: K.Response.error, message: K.Response.emptyField)
                return
                
        }
        
        if passwordField.text == confirmPasswordField.text {
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                
                guard error == nil else {
                    
                    if let errorDescription = error?.localizedDescription {
                        
                        self.showAlert(title: K.Response.error, message: errorDescription)
                    }
                    
                    return
                }
                
                self.showAlertWhenSuccesfully(title: K.Response.success, message: K.Response.registrationCompleted)
                
            })
        } else {
            showAlert(title: K.Response.error, message: K.Response.passwordDoesntMatch)
        }
        
    }
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: K.Response.retry, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showAlertWhenSuccesfully(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: K.Response.done, style: UIAlertAction.Style.default, handler:{action in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
}


