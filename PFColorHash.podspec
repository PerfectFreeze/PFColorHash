Pod::Spec.new do |s|
  s.name                  = "PFColorHash"
  s.version               = "0.1"
  s.summary               = "Generate color based on the given string."
  s.homepage              = "https://github.com/PerfectFreeze/PFColorHash"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "Cee" => "cee@chu2byo.com" }
  s.social_media_url      = "https://twitter.com/Ceecirno"
  s.platform              = :ios 
  s.ios.deployment_target = 8.0
  s.source                = { :git => "https://github.com/PerfectFreeze/PFColorHash.git", :tag => "v#{s.version.to_s}" }
  s.source_files          = "Class/*.swift"
  s.requires_arc          = true
end