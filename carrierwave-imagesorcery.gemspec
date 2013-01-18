require File.expand_path('../lib/carrierwave-imagesorcery/version', __FILE__)

require 'bundler/version'

Gem::Specification.new do |gem|
  gem.authors = ["Carlo Bertini"]
  gem.email = ["waydotnet@gmail.com"]
  gem.description = "CarrierWave Additional processing to support ImageSorcery"
  gem.summary = "ImageSorcery carrierwave processor"
  gem.homepage = "http://www.waydotnet.com"
  gem.platform       = Gem::Platform::RUBY

  gem.extra_rdoc_files = ["README.md"]
  gem.rdoc_options = ["--main"]
  gem.add_development_dependency 'rspec', '~> 2.12.0'
  gem.add_development_dependency 'rake','~> 10.0.2'

  gem.add_dependency 'carrierwave'
  gem.add_dependency 'image_sorcery','>= 1.1.0'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "carrierwave-imagesorcery"
  gem.require_paths = ["lib"]
  gem.version       = CarrierWave::ImageSorcery::VERSION
end
