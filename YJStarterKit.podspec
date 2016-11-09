#
# Be sure to run `pod lib lint StarterKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = "YJStarterKit"
    s.version          = "0.1.0"
    s.summary          = "iOS starter kit."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
    s.description      = <<-DESC
    Simple iOS starter kit.
                       DESC

    s.homepage         = "https://github.com/hujian/YJStarterKit.git"
    s.license          = 'MIT'
    s.author           = { "一剑" => "hujian2009@gmail.com" }
    s.source           = { :git => "https://github.com/hujian/YJStarterKit.git", :tag => s.version.to_s }

    s.platform     = :ios, '8.0'
    s.requires_arc = true

    s.source_files = 'StarterKit/Classes/**/*'

    s.resource_bundles = {
        'StarterKit' => ['StarterKit/Assets/**/*.{png,gif}']
    }

    s.public_header_files = 'StarterKit/Classes/**/*.h'
    s.frameworks = 'UIKit', 'MobileCoreServices', 'SystemConfiguration'

    s.dependency 'pop'
    s.dependency 'AFNetworking'
    s.dependency 'Overcoat'
    s.dependency 'Overcoat+ReactiveCocoa', '~> 4.0.0-beta.2'
    s.dependency 'OHHTTPStubs'
    s.dependency 'RETableViewManager'
    s.dependency 'CocoaLumberjack', '2.3.0'
    s.dependency 'XCDLumberjackNSLogger', '~> 1.1'
    s.dependency 'Aspects'
    s.dependency 'SDWebImage'
    s.dependency 'HexColors'
    s.dependency 'DZNEmptyDataSet'
    s.dependency 'ReactiveCocoa', '2.5.0'
    s.dependency 'Wonderful'
    s.dependency 'PINCache'
    s.dependency 'NSDate-Escort'
    s.dependency 'RMStore'

end
