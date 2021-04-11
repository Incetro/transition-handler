Pod::Spec.new do |spec|
  spec.name          = 'TransitionHandler'
  spec.module_name   = 'TransitionHandler'
  spec.version       = '0.0.3'
  spec.license       = 'MIT'
  spec.authors       = { 'incetro' => 'incetro@ya.ru', 'Dmitry Savinov' => 'savinov.dsta@gmail.com' }
  spec.homepage      = "https://github.com/Incetro/transition-handler.git"
  spec.summary       = 'Assistant for navigating between modules'

  spec.ios.deployment_target   = "11.0"
  spec.tvos.deployment_target  = "11.0"

  spec.swift_version = '5.0'
  spec.source        = { git: "https://github.com/Incetro/transition-handler.git", tag: "#{spec.version}" }
  spec.source_files  = "Sources/TransitionHandler/**/*.{h,swift}"
end