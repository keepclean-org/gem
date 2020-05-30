require_relative 'lib/keepclean/version'

Gem::Specification.new do |s|
  s.name        = 'keepclean'
  s.version     = Keepclean::VERSION
  s.date        = '2020-05-30'
  s.summary     = "Keep clean!"
  s.description = "Keep your repo clean with simple CI rules"
  s.authors     = ["Yoann Lecuyer"]
  s.email       = 'yoann.lecuyer@gmail.com'
  s.files       = Dir.glob("{bin,lib}/**/*")
  s.executables = ['keepclean']
  s.homepage    = 'https://rubygems.org/gems/keepclean'
  s.license     = 'MIT'
  s.add_runtime_dependency 'rubocop', '~> 0.85.1'
  s.add_runtime_dependency 'brakeman', '~> 4.8.2'
  s.add_runtime_dependency 'bundler-audit', '~> 0.7'
  s.add_runtime_dependency 'danger', '~> 8.0.1'
  s.add_runtime_dependency 'danger-gitlab', '~> 8.0.0'
  s.add_runtime_dependency 'rails_best_practices', '~> 1.20.0'
  s.add_runtime_dependency 'reek', '~> 5.6.0'
  s.add_runtime_dependency 'flay', '~> 2.12.1'
  s.add_runtime_dependency 'flog', '~> 4.6.4'
  s.add_runtime_dependency 'erb_lint', '~> 0.0.10'
  s.add_runtime_dependency 'license_finder', '~> 6'
  s.add_runtime_dependency 'activesupport', '~> 6.0.3.1'
  s.add_runtime_dependency 'ruby2ruby', '~> 2.4.4'
  s.add_runtime_dependency 'pronto', '~> 0.10.0'
  s.add_runtime_dependency 'pronto-reek', '~> 0.10.0'
  s.add_runtime_dependency 'pronto-flay', '~> 0.10.0'
  s.add_runtime_dependency 'pronto-brakeman', '~> 0.10.0'
  s.add_runtime_dependency 'pronto-rails_best_practices', '~> 0.10.0'
  s.add_runtime_dependency 'pronto-rubocop', '~> 0.10.0'
  s.add_runtime_dependency 'pronto-erb_lint', '~> 0.1.5'
end
