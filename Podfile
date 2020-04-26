source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
inhibit_all_warnings!

use_frameworks!

target 'YAWA-Demo' do
  pod 'SnapKit'
  
  pod 'OHHTTPStubs/Swift', '~> 6.1.0'
  pod 'OHHTTPStubs', '~> 6.1.0'
end

target 'YAWA-DemoTests' do
  pod 'SnapKit'
  
  pod 'OHHTTPStubs/Swift', '~> 6.1.0'
  pod 'OHHTTPStubs', '~> 6.1.0'
end

target 'YAWA-DemoUITests' do
  pod 'SnapKit'
  
  pod 'OHHTTPStubs/Swift', '~> 6.1.0'
  pod 'OHHTTPStubs', '~> 6.1.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.name == 'Debug'
        config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
      else
        config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
      end
    end
  end
end
