require 'rubygems'
require 'bundler'
Bundler.require(:default)
require 'sass/plugin/rack'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

require './caesar'
run Caesar
