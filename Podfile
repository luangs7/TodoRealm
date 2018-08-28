# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!

  # Pods for TodoRealm
def default_pods
    pod 'RealmSwift'
    pod 'Kingfisher', '~> 4.0'
    pod 'Alamofire', '~> 4.7'
    #εντροπία
end


target 'TodoRealm' do
    default_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
      	    config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
        end
    end
end
