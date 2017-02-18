xcodeproj 'LifeSound.xcodeproj'
workspace 'LifeSound.xcworkspace'
platform :ios, '10.0'
inhibit_all_warnings!

source 'https://github.com/artsy/Specs.git'
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

def shared_pods
      pod 'RealmSwift'
      #pod 'SwiftyBeaver'
end

target 'LifeSound' do
    shared_pods
end

target 'LifeSoundTests' do
    shared_pods
end

target 'LifeSoundUITests' do
    shared_pods
end

#target 'iSquash WatchKit Extension' do
#    platform :watchos, '3.1'
#    shared_pods
#end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
