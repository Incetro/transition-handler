Pod::Spec.new do |spec|
  spec.name          = 'TransitionHandler'
  spec.version       = '0.0.1'
  spec.license       = 'MIT'
  spec.authors       = { 'incetro' => 'incetro@ya.ru', 'Dmitry Savinov' => 'savinov.dsta@gmail.com' }
  spec.homepage      = "https://github.com/Incetro/incetro-pod-template.git"
  spec.summary       = 'Open Source'
  spec.platform      = :ios, "12.0"
  spec.swift_version = '4.0'
  spec.source        = { git: "https://github.com/Incetro/incetro-pod-template.git", tag: "#{spec.version}" }
  spec.source_files  = "Sources/TransitionHandler/**/*.{h,swift}"
end