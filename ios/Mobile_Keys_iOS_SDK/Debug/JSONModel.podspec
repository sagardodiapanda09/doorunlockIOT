Pod::Spec.new do |s|
    s.name         = 'JSONModel'
    s.version      = '0.2.5'
    s.summary      = 'JSONModel Framework for iOS'
    s.description  = 'This is the JSONModel framework required for SeosMobileKeysSDK.'
    s.homepage     = 'https://your-framework-website.com'
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { 'Arun Patel' => 'your.email@example.com' }
    s.platform     = :ios, '12.0'
    s.source       = { :path => '.' }
    s.vendored_frameworks = 'JSONModel.xcframework'
    s.requires_arc = true
  end