//
//  DataValidator.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit

//Class for validating data before server ever has an opportunity to kick in
class DataValidator: NSObject {

    typealias DataValidatorCompletion = (isValid:Bool) -> Void

    class func validateAuthData(email: String, password: String, completionHandler: DataValidatorCompletion) {
        let flag = self.isValidEmail(email) && self.isValidPassword(password) ? true : false
        completionHandler(isValid: flag)
    }

    // MARK: - Internal Data Validation

    class func isValidEmail(email:String) -> Bool {
        //This should work ;)
        if email.characters.count > 128 {
            return false
        }
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .CaseInsensitive)
            return regex.firstMatchInString(email, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, email.characters.count)) != nil
        } catch {
            return false
        }
    }

    class func isValidPassword(password:String) -> Bool {
        for chr in password.characters {
            //No magic numbers, just API reqs + some magic
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && password.characters.count > 4 && password.characters.count < 32) {
                return false
            }
        }
        return true
    }
}