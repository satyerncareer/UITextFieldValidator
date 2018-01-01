//
//  Validator.swift
//  TextFieldValidator
//
//  Created by Satyen on 30/12/17.
//  Copyright © 2017 Satyendra Chauhan. All rights reserved.
//

import Foundation
import UIKit

public class Validator: NSObject {
    
    public static var shareInstance:Validator{
        return Validator()
    }
    
    public func textFieldValidator(withRange: (textField:UITextField, minRange:Int, maxRange:Int)...,CompletionHandler: (_ textField:UITextField? ,_ success:Bool) -> Void){
        var isValidatedFields:Bool? = true
        var notValidatedTextField:UITextField?
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
            notValidatedTextField = textFld
        }
        
        if let isValid = isValidatedFields{
            if isValid {
                CompletionHandler(notValidatedTextField,isValid)
            }else{
                CompletionHandler(nil,isValid)
            }
        }
        
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
    public func textFieldValidator(textField:UITextField... ,CompletionHandler: (_ textField:UITextField? ,_ success:Bool) -> Void){
        var isValidated:Bool? = true
        var notValidatedTextField:UITextField?
        for txtFlds in textField {
           
            isValidated = validateSingleField(textField: txtFlds)
            notValidatedTextField = txtFlds
            if isValidated == false{
                break
            }
        }
        
        if let isValid = isValidated{
            if isValid {
                CompletionHandler(notValidatedTextField,isValid)
            }else{
                CompletionHandler(nil,isValid)
            }
        }
    }
    //Validate Single Field
    private func validateSingleField(textField: UITextField)->Bool?{
        var isValidated: Bool? = true
        if let content = textField.textContentType{
            isValidated = checkContentType(contentType: content, textField: textField)
           
        }else{
            isValidated = checkKeyboardType(keyboardType: textField.keyboardType, textField: textField)
        }
        return isValidated
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
    //MARK: - Validate View
    /**
     CompletionHandler is contained two variable textFields and success
     * textFields: [UITextField] : Contains array of unvarified textfields
     * success :  containe false if any one of textfield will not verified
     
    */
    public func validate(withView view: UIView,CompletionHandler: (_ textFields: [UITextField]? ,_ success: Bool) -> Void){
        let textFieldArray: [UITextField] = view.subviews.filter{$0.isKind(of: UITextField.self)} as! [UITextField]
    
        let validatedField = textFieldArray.filter{
            !validateSingleField(textField: $0)!

        }
        if validatedField.count == 0{
            CompletionHandler(nil, true)
        }else{
            CompletionHandler(validatedField, false)
        }
    }
}
