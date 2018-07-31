#
# Be sure to run `pod lib lint XAbstractionLibrary-UICommon.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XAbstractionLibrary-UICommon'
  s.version          = '0.0.3'
  s.summary          = 'XAbstractionLibrary-UICommon是基础的UI相关组件.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
XAbstractionLibrary-UICommon是基础的UI相关组件，解决页面级、空间级的开发效率低下的问题.
                       DESC

  s.homepage         = 'https://github.com/jiaojiaozhe/XAbstractionLibrary-UICommon'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jiaojiaozhe' => 'bluebiao@163.com' }
  s.source           = { :git => 'https://github.com/jiaojiaozhe/XAbstractionLibrary-UICommon.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'XAbstractionLibrary-UICommon/Classes/**/*'
  
  s.resource_bundles = {
     'XAbstractionLibrary-UICommon' => ['XAbstractionLibrary-UICommon/Assets/*.xib']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

    s.dependency 'XAbstractionLibrary-NetWork'
    s.dependency 'XAbstractionLibrary-Parse'
end
