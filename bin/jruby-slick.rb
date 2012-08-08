#!/usr/bin/env ruby
require 'rubygems'
require 'rake'

gem_dir = Gem::Specification.find_by_name("jruby-slick").gem_dir

Rake.application.rake_require "jruby-slick", ["#{gem_dir}/jruby-slick/tasks"]
Rake::Task['download_slick'].invoke
Rake::Task['setup_natives'].invoke
Rake::Task['build_example'].invoke