require 'rubygems' unless defined? Gem
require 'bundler/setup'
require 'carrierwave'

require(File.expand_path('../../lib/carrierwave-imagesorcery', __FILE__))

def file_path(*paths)
  File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', *paths))
end

def check_dimension(x, y)
  {:x => x, :y => y}
end
