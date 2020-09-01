# XAbstractionLibrary-UICommon

[![CI Status](https://img.shields.io/travis/jiaojiaozhe/XAbstractionLibrary-UICommon.svg?style=flat)](https://travis-ci.org/jiaojiaozhe/XAbstractionLibrary-UICommon)
[![Version](https://img.shields.io/cocoapods/v/XAbstractionLibrary-UICommon.svg?style=flat)](https://cocoapods.org/pods/XAbstractionLibrary-UICommon)
[![License](https://img.shields.io/cocoapods/l/XAbstractionLibrary-UICommon.svg?style=flat)](https://cocoapods.org/pods/XAbstractionLibrary-UICommon)
[![Platform](https://img.shields.io/cocoapods/p/XAbstractionLibrary-UICommon.svg?style=flat)](https://cocoapods.org/pods/XAbstractionLibrary-UICommon)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

XAbstractionLibrary-UICommon is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XAbstractionLibrary-UICommon'
```

## Author

jiaojiaozhe, bluebiao@163.com

## License

XAbstractionLibrary-UICommon is available under the MIT license. See the LICENSE file for more info.

## Publish
本地验证： pod lib lint XAbstractionLibrary-UICommon.podspec --verbose --allow-warnings --sources="https://github.com/jiaojiaozhe/XAbstractionLibrary-Specs,https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git"
本地验证&远程验证: pod spec lint --verbose --allow-warnings --sources="https://github.com/jiaojiaozhe/XAbstractionLibrary-Specs,https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git"
发布：pod repo push jiaojiaozhe XAbstractionLibrary-UICommon.podspec --verbose --allow-warnings --sources="https://github.com/jiaojiaozhe/XAbstractionLibrary-Specs,https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git"
