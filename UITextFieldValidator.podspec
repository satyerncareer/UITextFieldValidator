#
# Be sure to run `pod lib lint UITextFieldValidator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'UITextFieldValidator'
s.version          = '0.1.5'
s.summary          = 'UITextFieldValidator is provide textfield validation.'

# UITextFieldValidation is improved validation base on you UITextField type. Now there is no need to write bunch of code for validate your textfield.


s.description      = <<-DESC
UITextFieldValidation is improved validation base on you UITextField type. Now there is no need to write bunch of code for validate your textfield.
DESC

s.homepage         = 'https://github.com/satyerncareer/UITextFieldValidator'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'satyencareer@gmail.com' => 'satyendra.chauhan@appster.in' }
s.source           = { :git => 'https://github.com/satyerncareer/UITextFieldValidator.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '11.0'

s.source_files = 'UITextFieldValidator/Classes/**/*'

# s.resource_bundles = {
#   'UITextFieldValidator' => ['UITextFieldValidator/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end

