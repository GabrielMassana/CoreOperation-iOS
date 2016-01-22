Pod::Spec.new do |s|

  s.name         = "CoreOperation"
  s.version      = "1.0.7"
  s.summary      = "Wrapper project to simplify NSOperation and NSOperationQueue."

  s.homepage     = "https://github.com/GabrielMassana"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md'}
  s.author       = { "Gabriel Massana" => "gabrielmassana@gmail.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/GabrielMassana/CoreOperation-iOS.git", :tag => s.version, :branch => "master"}
  
  s.source_files  = "CoreOperation-iOS/**/*.{h,m}"
  s.public_header_files = "CoreOperation-iOS/**/*.{h}"

  s.requires_arc = true

end

