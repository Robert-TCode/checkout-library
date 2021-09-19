Pod::Spec.new do |s|
    s.name                  = 'CheckoutLibraryTcode'
    s.version               = '1.0.0'
    s.summary               = 'Swift Checkout Library XCFramework'
    s.homepage              = 'https://github.com/Robert-TCode/checkout-library'
    s.license               = { :type => 'Copyright', :text => 'Copyright (c) 2021 Crowd Connected Ltd' }
    s.author                = { 'Robert TCode' => 'roberttcode@gmail.com' }
    s.source                = { :git => 'https://github.com/Robert-TCode/checkout-library.git', :tag => s.version.to_s }
    s.vendored_frameworks   = 'CheckoutLibraryTcode.xcframework'
    s.platform              = :ios
    s.swift_version         = '5.4'
    s.ios.deployment_target = '13.0'
  end