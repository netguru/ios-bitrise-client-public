#
#  Podfile
#
#  Copyright (c) 2022 Netguru Sp. z o.o. All rights reserved.
#

# Pod sources
source 'https://github.com/CocoaPods/Specs.git'

# Initial configuration
platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

workspace 'BitriseClient.xcworkspace'

pod 'SwiftLint', '~> 0.47.1'
pod 'SwiftFormat/CLI', '~> 0.49.9'

# Main app
target 'BitriseClient' do
  project 'BitriseClient'
end

target 'BitriseClientTests' do
	project 'BitriseClient'
end

def generate_targets(name)
  target "#{name}" do
    project "Modules/#{name}/#{name}"
  end

  target "#{name}DemoApp" do
    project "Modules/#{name}/#{name}"
  end

  target "#{name}Tests" do
    project "Modules/#{name}/#{name}"
    pod 'SnapshotTesting', '~> 1.9.0'
  end
end

generate_targets 'ApplicationsList'
generate_targets 'BitriseAuthentication'
generate_targets 'BuildsList'
generate_targets 'Common'
generate_targets 'CommonUI'
generate_targets 'GeneralScreens'
generate_targets 'Networking'
generate_targets 'StartBuild'

target "ApplicationDetails" do
  project "Modules/ApplicationDetails/ApplicationDetails"
  pod 'Highlightr'
end

target "ApplicationDetailsDemoApp" do
  project "Modules/ApplicationDetails/ApplicationDetails"
end

target "ApplicationDetailsTests" do
  project "Modules/ApplicationDetails/ApplicationDetails"
  pod 'SnapshotTesting', '~> 1.9.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
     end
   end
end
