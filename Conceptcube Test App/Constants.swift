//
//  Constants.swift
//  Conceptcube Test App
//
//  Created by Dinh Quy on 1/31/22.
//  Copyright © 2022 Dinh Quy. All rights reserved.
//

import Foundation
import UIKit

struct K {
    
    struct Images {
        
        static let loginTopImage = UIImage(named: "main_top.png")
        static let loginMainImage = UIImage(named: "login.png")
        static let loginBottomImage = UIImage(named: "login_bottom.png")
        static let cardFaceUp = UIImage(named: "face_up.png")
        
    }
    
    struct Icons {
        
        static let usernameFieldIcon = "username_icon.png"
        static let passwordFieldIcon = "password_icon.png"
        static let emailFieldIcon = "email_icon.png"
        static let birthdayFieldIcon = "calendar_icon.png"
        static let emailNotAvailable = "cross.png"
        static let emailAvailable = "tick.png"
        
    }
    
    struct Colors {
        
        static let backgroundColor = UIColor.white
        static let primaryColor = UIColor(rgb: 0x663298)
        static let buttonDeactiveColor = UIColor(rgb: 0xCDCDCD)
        static let smallTextColor = UIColor(rgb: 0xB39BCD)
        static let fieldBackgroundColor = UIColor(rgb: 0xF1E6FF)
        static let fieldBorderColor = CGColor(srgbRed: 241, green: 230, blue: 255, alpha: 1)
        static let buttonTextActiveColor = UIColor(rgb: 0xFFFFFF)
        static let buttonTextDeactiveColor = UIColor(rgb: 0xE2E3E7)
        static let secondaryColor = UIColor(rgb: 0xE6DCF3)
        static let buttonSecondaryTextColor = UIColor(rgb: 0x67319A)
        static let errorColor = UIColor(rgb: 0xF44337)
        static let validColor = UIColor(rgb: 0x43b29e)
    }
    
    struct Labels {
        
        static let emailLabel = "Email"
        static let passwordLabel = "Password"
        static let loginLabel = "Login"
        static let registrationReminder = "Don't have an account?"
        static let signupLabel = "Signup"
        static let backLabel = "Back"
        static let joinLabel = "Join now"
        static let checkLabel = "Check"
        
    }
    
    struct Response {
        
        static let retry = "Retry"
        static let done = "Done"
        static let error = "Error"
        static let success = "Congrats"
        static let missingEmail = "Please enter your email"
        static let emailAlready = "The email address is already"
        static let emailAvailable = "Email is available"
        static let emptyField = "Please fill in all fields!"
        static let registrationCompleted = "Successful registration, please login to use."
        static let passwordDoesntMatch = "Confirm password doesn't match"
        
        
    }
    

    
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
