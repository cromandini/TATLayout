Pod::Spec.new do |s|
  s.name                  = "TATLayout"
  s.version               = "1.0.1"
  s.license               = "MIT"
  s.summary               = "An expressive, simple yet powerful way for coding layout constraints in iOS."
  s.description           = <<-DESC
                            TATLayout aims to reduce considerably the amount of lines of code used when coding layout constraints in iOS. It provides a high level API to layout constraints that makes your layouts easier to read, mantain and modify dynamically.
                            
                            Features:
                            * Category in `NSLayoutConstraint` providing a factory method for creating constraints using a linear equation format string.
                            * Category in `NSLayoutConstraint ` providing methods for activation and deactivation that can be used in iOS 6+ but uses iOS 8 when available.
                            * A couple of helper methods useful for working with layouts.
                            DESC
  s.homepage              = "https://github.com/cromandini/TATLayout"
  s.author                = { "Claudio Romandini" => "cromandini@me.com" }
  s.source                = { :git => "https://github.com/cromandini/TATLayout.git",
                              :tag => s.version.to_s }
  s.requires_arc          = true
  s.platform              = :ios, "6.0"
  s.ios.deployment_target = "6.0"
  s.source_files          = "TATLayout/*.{h,m}"
  s.public_header_files   = "TATLayout/{TATLayout,TATLayoutHelper,NSLayoutConstraint+TATFactory,NSLayoutConstraint+TATActivation,NSLayoutConstraint+TATInstallation}.h"
end
