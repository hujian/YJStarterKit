platform :ios, '8.0'
inhibit_all_warnings!

workspace 'YJStarterKit'

target 'Example' do
#  pod 'YJStarterKit', :path => '.'
    pod 'pop'
    pod 'AFNetworking'
    pod 'RETableViewManager'
    pod 'CocoaLumberjack', '2.3.0'
    pod 'Aspects'
    pod 'SDWebImage'
    pod 'HexColors'
    pod 'DZNEmptyDataSet'
    pod 'ReactiveCocoa', '2.5.0'
end

xcodeproj 'Example/Example.xcodeproj'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'NO'
            config.build_settings['ARCHS'] = 'armv7 armv7s arm64'
            config.build_settings['VALID_ARCHS'] = 'armv6 armv7 armv7s arm64'
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
        end
    end
end
