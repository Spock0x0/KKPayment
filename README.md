# KKPayment

[![CI Status](https://img.shields.io/travis/Spock/KKPayment.svg?style=flat)](https://travis-ci.org/Spock/KKPayment)
[![Version](https://img.shields.io/cocoapods/v/KKPayment.svg?style=flat)](https://cocoapods.org/pods/KKPayment)
[![License](https://img.shields.io/cocoapods/l/KKPayment.svg?style=flat)](https://cocoapods.org/pods/KKPayment)
[![Platform](https://img.shields.io/cocoapods/p/KKPayment.svg?style=flat)](https://cocoapods.org/pods/KKPayment)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

KKPayment is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KKPayment'
```

## Question
1. applicationOpenURL 是哪邊來 第一次 call 完 payment api 拿到？
2. 還需要 call payment return 嗎？，如果不是，是透過 webview 溝通回 app ?


## Idea
1. finish checkout
2. call payment auth (sdk)
3. get redirect url (sdk)
4. web view open it
5. receive result message

## Author

Spock, spock.hsueh@kkday.com

## License

KKPayment is available under the MIT license. See the LICENSE file for more info.
