#
#  Be sure to run `pod spec lint VTImageFilterPicker.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "VTImageFilterPicker"
  s.version      = "1.0.0"
  s.summary      = "A beautifil and easy use image filter picker."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = "Just likes Instagram upload image view, easy to use and fully customization."
  s.license      = "MIT"
  s.author             = { "Vincent" => "keepexcelsior@gmail.com" }
  s.source = { :path => '.' }
  s.source_files = "VTImageFilterPicker", "VTImageFilterPicker/**/*.{h,m,swift}"
  s.homepage = "https://www.linkedin.com/in/lin-vincent-99659715b/"

end
