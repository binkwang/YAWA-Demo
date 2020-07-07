source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

use_frameworks!
inhibit_all_warnings! # ignore all warnings from all pods

abstract_target 'YAWA' do
  
  target 'YAWA-Demo' do
    # inherit! :complete # The target inherits all behaviour from the parent. (by default if you do not specify any inherit!)
    pod 'SnapKit'
    
    # TODO: fix error when introduce EarlGreyApp
    # Fatal failure: EarlGrey's app component has been launched without edoPort assigned. You are probably running the application under test by itself, which does not work since the embedded EarlGrey component needs its test counterpart present.
    # pod 'EarlGreyApp'
  end
  
  abstract_target 'Tests' do
    pod 'OHHTTPStubs/Swift', '~> 6.1.0'
    pod 'OHHTTPStubs', '~> 6.1.0'

    target 'YAWA-DemoTests'
    
    target 'YAWA-DemoUITests' do
      # pod 'EarlGreyTest'
      # pod 'eDistantObject', '0.9.0'
    end
  end
  
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

# abstract_target: https://guides.cocoapods.org/syntax/podfile.html#abstract_target
# inherit!: https://guides.cocoapods.org/syntax/podfile.html#inherit_bang
