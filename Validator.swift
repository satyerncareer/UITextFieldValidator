//
//  Validator.swift
//  TextFieldValidator
//
//  Created by Satyen on 30/12/17.
//  Copyright © 2017 CompanyName. All rights reserved.
//

import Foundation
import UIKit

public class Validator: NSObject {
    
    public static var shareInstance:Validator{
        return Validator()
    }
    
    public func textFieldValidator(withRange: (textField:UITextField, minRange:Int, maxRange:Int)...)->Bool{
        var isValidatedFields:Bool? = true
        for (textFld, minRange, maxRange) in withRange {
            if isValidatedFields == true{
                if let contentType = textFld.textContentType{
                    isValidatedFields = checkContentType(contentType: contentType, textField: textFld)
                }else{
                    isValidatedFields =  checkKeyboardType(keyboardType: textFld.keyboardType, textField: textFld)
                    
                }
                if isValidatedFields == false{
                    break
                }
            }
            isValidatedFields = checkRange(rangeMin: minRange, rangeMax: maxRange, textField: textFld)
        }
        guard let validBool = isValidatedFields else {
            return false
        }
        return validBool
    }
    private func checkRange(rangeMin:Int = 0, rangeMax:Int, textField:UITextField)->Bool{
        guard let textRange =  textField.text?.characters.count else {
            return false
        }
        if textRange >= rangeMin && textRange <= rangeMax{
            return true
        }else{
            return false
        }
    }
    //MARK: - validator
    public func textFieldValidator(textField:UITextField...)->Bool{
        var isValidated:Bool? = true
        for txtFlds in textField {
            if let content = txtFlds.textContentType{
                isValidated = checkContentType(contentType: content, textField: txtFlds)
                if isValidated == false{
                    break
                }
            }else{
                isValidated = checkKeyboardType(keyboardType: txtFlds.keyboardType, textField: txtFlds)
                if isValidated == false{
                    break
                }
            }
            
        }
        guard let valid = isValidated else {
            return false
        }
        return valid
    }
    //MARK: - Validate tetxfield with content type
    private func checkContentType(contentType: UITextContentType!, textField: UITextField)->Bool?{
        switch contentType{
        case textFieldContentType.name,
             textFieldContentType.familyName, textFieldContentType.addressCity, textFieldContentType.addressState, textFieldContentType.addressCityAndState, textFieldContentType.countryName, textFieldContentType.fullStreetAddress, textFieldContentType.givenName,
             textFieldContentType.jobTitle,
             textFieldContentType.location,
             textFieldContentType.middleName,
             textFieldContentType.nickname,
             textFieldContentType.organizationName
        , textFieldContentType.nameSuffix,
          textFieldContentType.namePrefix, textFieldContentType.username:
            return textField.text?.isBlank
        case textFieldContentType.telephoneNumber:
            return textField.text?.isPhoneNumber
        case textFieldContentType.emailAddress:
            return textField.text?.isEmail
        case textFieldContentType.URL:
            return textField.text?.isURL
        case textFieldContentType.password:
            return textField.text?.isValidPassword
        default:
            break
        }
        return false
    }
    //MARK: - Validate textfields with keyboard type
    private func checkKeyboardType(keyboardType: UIKeyboardType, textField:UITextField)->Bool?{
        switch keyboardType {
        case .default, .asciiCapable, .decimalPad, .asciiCapableNumberPad, .namePhonePad, .numberPad:
            return textField.text?.isBlank
        case .emailAddress:
            return textField.text?.isEmail
        case .phonePad:
            return textField.text?.isPhoneNumber
        case .URL:
            return textField.text?.isURL
        default:
            break
        }
        if textField.isSecureTextEntry{
            return textField.text?.isValidPassword
        }
        return false
    }
}
extension String {
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return !trimmed.isEmpty
        }
    }
    
    //Validate Email
    
    var isEmail: Bool {
        let lastChar = self.last
        if self.contains(" ") || lastChar == "."{
            return false
        }
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    //validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil){
                
                if(self.characters.count>=6 && self.characters.count<=20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
    
    var isPhoneNumber: Bool {
        let PHONE_REGEX = "^[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    
    var isURL: Bool {
        //Check for nil
        if !self.isEmpty {
            let url = URL(string: self)
            // check if your application can open the NSURL instance
            return UIApplication.shared.canOpenURL(url!)
            
        }
        return false
    }
}


