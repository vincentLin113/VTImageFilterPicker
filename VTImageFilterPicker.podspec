#
#  Be sure to run `pod spec lint VTImageFilterPicker.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "VTImageFilterPicker"
  s.version      = "1.0.1"
  s.summary      = "A beautiful and easy use image filter picker."
  s.description  = "Just likes Instagram upload image view, easy to use and fully customization."
  s.license      = "MIT"
  s.author       = { "Vincent" => "keepexcelsior@gmail.com" }
  s.source = { :git => 'https://github.com/vincentLin113/VTImageFilterPicker.git', :tag => '1.0.0.7' }
  s.source_files = 'Source/**/*.{swift,metal,h,m}'
  s.homepage = 'https://github.com/vincentLin113/VTImageFilterPicker'
  s.ios.deployment_target = "9.0"
  s.swift_version = '4.1'

end
