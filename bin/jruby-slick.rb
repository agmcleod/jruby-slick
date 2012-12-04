#!/usr/bin/env ruby
require 'rubygems'
require 'rake'

gem_dir = Gem::Specification.find_by_name("jruby-slick").gem_dir
Rake.application.rake_require "jruby-slick", ["#{gem_dir}/jruby-slick/tasks"]

args = ARGV
nothing_run = true

if args.include? "install"
  Rake::Task['download_slick'].invoke
  Rake::Task['setup_natives'].invoke
  Rake::Task['build_example'].invoke
  nothing_run = false
end

if args.include? "gamestate"
  idx = args.index "gamestate"
  filename = "example_game_state.rb"
  classname = "ExampleGameState"
  unless args[idx+1].nil?
    filename = "#{args[idx+1]}_game_state.rb"
    classname = "#{args[idx+1]}_game_state".gsub(/\_[a-z]/) do |m|
      m.upcase.gsub("_","")
    end.capitalize
  end

  Rake::Task[:generate_game_state].invoke(filename, classname)
  nothing_run = false
end

if nothing_run || args.include?("-h") || args.include?("--help")
  puts "\njruby slick commands:\n"
  puts "    install            - downloads the slick.jar, lwjgl natives, and gives an example file."
  puts "    gamestate [name]   - generates a base gamestate file for you in lib/. Optional name will change class & filename. Example: `jruby-slick.rb gamestate=awesome` would create awesome.rb"
  puts "    -h | --help        - shows this menu"
end