# XAbstractionLibrary-NetWork

[![CI Status](https://img.shields.io/travis/jiaojiaozhe/XAbstractionLibrary-NetWork.svg?style=flat)](https://travis-ci.org/jiaojiaozhe/XAbstractionLibrary-NetWork)
[![Version](https://img.shields.io/cocoapods/v/XAbstractionLibrary-NetWork.svg?style=flat)](https://cocoapods.org/pods/XAbstractionLibrary-NetWork)
[![License](https://img.shields.io/cocoapods/l/XAbstractionLibrary-NetWork.svg?style=flat)](https://cocoapods.org/pods/XAbstractionLibrary-NetWork)
[![Platform](https://img.shields.io/cocoapods/p/XAbstractionLibrary-NetWork.svg?style=flat)](https://cocoapods.org/pods/XAbstractionLibrary-NetWork)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

XAbstractionLibrary-NetWork is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XAbstractionLibrary-NetWork'
```

## Author

jiaojiaozhe, bluebiao@163.com

## License

XAbstractionLibrary-NetWork is available under the MIT license. See the LICENSE file for more info.

## Publish
本地验证： pod lib lint XAbstractionLibrary-NetWork.podspec --verbose --allow-warnings --sources="https://github.com/jiaojiaozhe/XAbstractionLibrary-Specs,https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git"
本地验证&远程验证: pod spec lint --verbose --allow-warnings --sources="https://github.com/jiaojiaozhe/XAbstractionLibrary-Specs,https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git"
发布：pod repo push jiaojiaozhe XAbstractionLibrary-NetWork.podspec --verbose --allow-warnings --sources="https://github.com/jiaojiaozhe/XAbstractionLibrary-Specs,https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git"
