#
# Be sure to run `pod lib lint ChainUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ChainUI'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ChainUI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/chengzongxin/ChainUI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chengzongxin' => 'joe.cheng@corp.to8to.com' }
  s.source           = { :git => 'https://github.com/chengzongxin/ChainUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

#  s.source_files = 'ChainUI/Classes/**/*'
  
  s.public_header_files = 'ChainUI/Classes/*.h'
  s.source_files = 'ChainUI/Classes/*.{h,m}'
  s.frameworks = 'Foundation', 'UIKit', 'CoreGraphics'
  s.subspec 'Private' do |ss|
    ss.source_files = 'ChainUI/Classes/Private/*.{h,m}'
    ss.public_header_files = "ChainUI/Classes/Private/*.h"
  end
  s.subspec 'Public' do |ss|
    ss.source_files = 'ChainUI/Classes/Public/*.{h,m}'
    ss.public_header_files = "ChainUI/Classes/Public/*.h"
    ss.dependency 'ChainUI/Private'
  end
  s.subspec 'Chainable' do |ss|
    ss.source_files = 'ChainUI/Classes/Chainable/*.{h,m}'
    ss.dependency 'ChainUI/Public'
    ss.dependency 'ChainUI/Private'
  end
  
  # s.resource_bundles = {
  #   'ChainUI' => ['ChainUI/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
