platform :ios, '13.1'
use_frameworks!

def shared_pods
  pod 'IGListKit', '4.0.0'
end

target 'MawiTestJob' do
  shared_pods
  pod 'RxSwift', '5.1.1'
  pod 'RxCocoa', '5.1.1'
  pod 'Realm', '4.4.0'
  pod 'RxRealm', '2.0.0'
  pod 'Charts', '3.4.0'
  pod 'Swinject', '2.7.1'
  pod 'R.swift', '5.1.0'
  pod 'BonMot', '5.5.1'
end

target 'MawiTestJobTests' do
    pod 'OHHTTPStubs/Swift', '8.0.0'
    shared_pods
end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          if config.name == 'OHHTTPStubs/Swift'
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
          end
        end
    end
end
