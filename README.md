# UITextField Validator

[![Version](https://img.shields.io/cocoapods/v/UITextFieldValidator.svg?style=flat)](http://cocoapods.org/pods/UITextFieldValidator)
[![License](https://img.shields.io/cocoapods/l/UITextFieldValidator.svg?style=flat)](https://github.com/satyerncareer/UITextFieldValidator/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/UITextFieldValidator.svg?style=flat)](http://cocoapods.org/pods/UITextFieldValidator)
[![Language](https://img.shields.io/badge/language-swift%204-green.svg)](https://github.com/satyerncareer/UITextFieldValidator)

UITextField Validator is a UITextField validator which can be use in different ways. So you would now focus on writing your core logic and let UITextFieldValidator handle all your field validations. For more info you can see "How to use" section bellow.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

UITextField Validator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'UITextFieldValidator','0.1.7'
```
### Note:
Deployment Target should be 11.0

## How it works

The validator check `ContentType` of your UITextField and according to ``ContentType`` it will validate text fields if ``ContentType`` is not set for your text field then it will validate according to your `KeyboardType`. All this take care by this lib.

## How to use
```ruby
import UITextFieldValidator
```

There are two version of validation here, one is for simple validation and second one is validation with range. Range validation will take two more input for minimum characters and the maximum characters

You can pass multiple UITextField in both methods.

### Simple validation


```ruby
Validator.shareInstance.textFieldValidator(textField: TextField_1,TextField_2,TextField_3...TextField_n) { (textField:UITextField, isSuccess) in
    //handle result here
}
```
### With range

```ruby
Validator.shareInstance.textFieldValidator(withRange: (textField: TextField_1,TextField_2,TextField_3...TextField_n, minRange: 1, maxRange: 50)) { (textField:UITextField, isSuccess) in
    //handle result here
}
```
Note :  When all textfields will be validated successfully then textfield will return nil else there will be a textfield which is not validated.

### With View
yourView is the view which contains all your UITextField which need to be validated
```ruby
Validator.shareInstance.validate(withView: yourView) { (textFields: [UITextField]?, isValidated) in
    if isValidated {
        //[UITextField]? will be nil
        print("valid field")
    }else{
        print("not valid field")
        //[UITextField]? will contaill all the non validated UITextFields
    }
}
```

## Author
### Satyendra Chauhan
satyenchauhan5@gmail.com

## License

UITextFieldValidator is available under the MIT license. See the LICENSE file for more info.
