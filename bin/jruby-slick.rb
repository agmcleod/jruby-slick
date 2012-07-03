require 'rubygems'
require 'rake'
require 'pry'

#binding.pry

Rake.application.rake_require "jruby-slick", File.expand_path("../jruby-slick/tasks", File.dirname(__FILE__))
Rake::Task['download_slick'].invoke