Pod::Spec.new do |s|

  s.name         = "CoreOperation"
  s.version      = "1.0.3"
  s.summary      = "A static library project that simplifies NSOperationQueue."

  s.homepage     = "https://github.com/GabrielMassana"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md'}
  s.author       = { "Gabriel Massana" => "gabrielmassana@gmail.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/GabrielMassana/CoreOperation-iOS.git", :tag => s.version, :branch => "master"}
  
  s.source_files  = "CoreOperation/CoreOperation/CoreOperation/**/*.{h,m}"
  s.public_header_files = "CoreOperation/CoreOperation/CoreOperation/**/*.{h}"

  s.requires_arc = true

end

