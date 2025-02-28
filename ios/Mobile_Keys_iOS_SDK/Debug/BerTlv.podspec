Pod::Spec.new do |s|
    s.name         = 'BerTlv'
    s.version      = '0.2.5'
    s.summary      = 'BerTlv Framework for iOS'
    s.description  = 'This is the BerTlv framework required for SeosMobileKeysSDK.'
    s.homepage     = 'https://your-framework-website.com'
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { 'Arun Patel' => 'your.email@example.com' }
    s.platform     = :ios, '12.0'
    s.source       = { :path => '.' }
    s.vendored_frameworks = 'BerTlv.xcframework'
    s.requires_arc = true
  end