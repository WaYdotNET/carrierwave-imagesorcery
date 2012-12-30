require 'rubygems' unless defined? Gem
# we need the actual library file
# require_relative '../lib/ms_translate'
# For Ruby < 1.9.3, use this instead of require_relative
require 'bundler/setup'
require 'carrierwave'

require(File.expand_path('../../lib/carrierwave-imagesorcery', __FILE__))

def file_path(*paths)
  File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', *paths))
end

def check_dimension(x, y)
  {:x => "#{x}", :y => "#{y}"}
end
