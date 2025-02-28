Pod::Spec.new do |s|
    s.name         = 'CocoaLumberjack'
    s.version      = '1.0.0'
    s.summary      = 'CocoaLumberjack Framework for iOS'
    s.description  = 'This is the CocoaLumberjack framework required for SeosMobileKeysSDK.'
    s.homepage     = 'https://your-framework-website.com'
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { 'Arun Patel' => 'your.email@example.com' }
    s.platform     = :ios, '12.0'
    s.source       = { :path => '.' }
    s.vendored_frameworks = 'CocoaLumberjack.xcframework'
    s.requires_arc = true
  end