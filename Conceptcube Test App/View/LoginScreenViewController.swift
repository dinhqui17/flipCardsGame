//
//  LoginScreenViewController.swift
//  Conceptcube Test App
//
//  Created by Dinh Quy on 1/31/22.
//  Copyright © 2022 Dinh Quy. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginScreenViewController: UIViewController {
    
    @IBOutlet weak var loginTopImage: UIImageView!
    @IBOutlet weak var loginMainImage: UIImageView!
    @IBOutlet weak var loginBottomImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registrationReminder: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailField.delegate = self
        passwordField.delegate = self
        setupUI()
        
        
        
    }
    
    func setupUI() {
        
        view.backgroundColor = K.Colors.backgroundColor
        
        loginTopImage.image = K.Images.loginTopImage
        loginTopImage.contentMode = UIView.ContentMode.scaleToFill
        
        loginBottomImage.image = K.Images.loginBottomImage
        loginBottomImage.contentMode = UIView.ContentMode.scaleToFill
        
        loginMainImage.image = K.Images.loginMainImage
        
        emailLabel.text = K.Labels.emailLabel
        emailLabel.textColor = K.Colors.smallTextColor
        
        passwordLabel.textColor = K.Colors.smallTextColor
        passwordLabel.text = K.Labels.passwordLabel
        
        emailField.backgroundColor = K.Colors.fieldBackgroundColor
        emailField.layer.cornerRadius = 15.0
        emailField.layer.borderWidth = 1.0
        emailField.layer.borderColor = K.Colors.fieldBorderColor
        emailField.layer.masksToBounds = true
        emailField.withImage(direction: .Left, iconName: K.Icons.emailFieldIcon)
        
        
        passwordField.backgroundColor = K.Colors.fieldBackgroundColor
        passwordField.layer.cornerRadius = 15.0
        passwordField.layer.borderWidth = 1.0
        passwordField.layer.borderColor = K.Colors.fieldBorderColor
        passwordField.layer.masksToBounds = true
        passwordField.withImage(direction: .Left, iconName: K.Icons.passwordFieldIcon)
        
        
        loginButton.backgroundColor = K.Colors.secondaryColor
        loginButton.setTitleColor(K.Colors.buttonSecondaryTextColor, for: .normal)
        loginButton.setTitle(K.Labels.loginLabel.uppercased(), for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        loginButton.layer.cornerRadius = 15.0
        loginButton.isEnabled = false
        
        registrationReminder.text = K.Labels.registrationReminder
        registrationReminder.textColor = K.Colors.smallTextColor
        registrationReminder.font = registrationReminder.font.withSize(15.0)
        
        signupButton.setTitleColor(K.Colors.primaryColor, for: .normal)
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        guard let username = emailField.text, !username.isEmpty,
            let password = passwordField.text, !password.isEmpty else {
                return
        }
        
        
        FirebaseAuth.Auth.auth().signIn(withEmail: username, password: password, completion: {result, error in
            
            guard error == nil else {
                self.showAlert(title: K.Response.error, message: error?.localizedDescription ?? "")
                return
            }
            
            let mainVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController") as! MainViewController
                
                self.navigationController?.pushViewController(mainVC, animated: true )
            
            
        })
        
    }
    
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: K.Response.retry, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}


extension UITextField {
    
    enum Direction {
        case Left
        case Right
    }
    
    func withImage(direction: Direction, iconName: String) {
        
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 45))
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 45))
        mainView.addSubview(view)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: iconName)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)
        
        if (Direction.Left == direction) {
            self.leftViewMode = .always
            self.leftView = mainView
        } else {
            self.rightViewMode = .always
            self.rightView = mainView
        }
    }
    
}

extension LoginScreenViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField)  {
        
        if let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty {
            
            loginButton.isEnabled = true
            loginButton.backgroundColor = K.Colors.primaryColor
            loginButton.setTitleColor(K.Colors.buttonTextActiveColor, for: .normal)
        
        } else {
            
            loginButton.isEnabled = false
            loginButton.backgroundColor = K.Colors.secondaryColor
            loginButton.setTitleColor(K.Colors.buttonSecondaryTextColor, for: .normal)
        }
        
       
    }
    
}
