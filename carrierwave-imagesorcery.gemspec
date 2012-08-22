# -*- encoding: utf-8 -*-
require File.expand_path('../lib/carrierwave-imagesorcery/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ["Carlo Bertini"]
  gem.email = ["waydotnet@gmail.com"]
  gem.description = "CarrierWave Additional processing to support ImageSorcery"
  gem.summary = "ImageSorcery carrierwave processor"
  gem.homepage = "http://www.waydotnet.com"

  gem.extra_rdoc_files = ["README.md"]
  gem.rdoc_options = ["--main"]
  gem.add_development_dependency "rspec"

  gem.add_dependency 'carrierwave'
  gem.add_dependency 'image_sorcery'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "carrierwave-imagesorcery"
  gem.require_paths = ["lib"]
  gem.version       = CarrierWave::ImageSorcery::VERSION
end
