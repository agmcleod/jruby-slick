require 'net/http'
require 'open-uri'
require 'fileutils'
require 'rubygems'
require 'zip/zipfilesystem'
require 'rbconfig'

desc 'Download Slick Distribution'
task :download_slick do
  FileUtils.mkdir_p "vendor/slick"

  res = Net::HTTP.get_response(URI("http://www.slick2d.org/downloads/slick.jar"))
  File.open("vendor/slick/slick.jar", "w+") do |f|
    f.write(res.body)
  end
  puts "slick.jar downloaded into vendor/slick directory"
end

desc 'Setup lwjgl natives'
task :setup_natives do
  FileUtils.mkdir_p "bin" unless File.exists? "bin"
  target = RbConfig::CONFIG['target_os'].downcase
  platform = []
  if target.index('mswin')
    platform << 'windows'
    puts "Determined you are using windows"
  elsif target.index('darwin')
    platform << 'macosx'
    puts "Determined you are on OS X"
  elsif target.index('linux')
    platform << 'linux'
    puts "Determined you are on Linux"
  end

  puts "Downloading LWJGL"
  open("lwjgl.zip", "wb") do |f|
    f.print open("http://downloads.sourceforge.net/project/java-game-lib/Official%20Releases/LWJGL%202.9.0/lwjgl-2.9.0.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fjava-game-lib%2Ffiles%2FOfficial%2520Releases%2FLWJGL%25202.9.0%2F&ts=1366913882&use_mirror=superb-dca3").read
  end

  puts "Finished downloading LWJGL"

  Zip::ZipFile.open("lwjgl.zip") do |natives|
    natives.each do |entry|
      if entry.file? && /^lwjgl-2.8.5\/native\/#{platform[0]}/ =~ entry.name
        target = "bin/#{entry.name.split('/')[-1]}"
        unless File.exists? target
          entry.extract target
          puts "wrote file: #{target}"
        end
      elsif entry.file? && entry.name == "lwjgl-2.8.5/jar/lwjgl.jar" || entry.name == "lwjgl-2.8.5/jar/jinput.jar"
        target = "vendor/slick/#{entry.name.split('/')[-1]}"
        unless File.exists? target
          entry.extract target
          puts "wrote file: #{target}"
        end
      end
    end
  end

  puts "removed lwjgl.zip"
  FileUtils.rm "lwjgl.zip"
end

desc 'Build base example file'
task :build_example do
  gem_dir = Gem::Specification.find_by_name("jruby-slick").gem_dir

  unless File.exists? "bin/example.rb"
    FileUtils.cp "#{gem_dir}/jruby-slick/template/example.rb", "bin/example.rb"
  end
end

desc 'generate a default gamestate file'
task :generate_game_state, :file_name, :class_name do |t, args|
  gem_dir = Gem::Specification.find_by_name("jruby-slick").gem_dir
  file_name = args[:file_name]
  class_name = args[:class_name]

  FileUtils.mkdir_p "lib"
  if File.exists? "lib/#{file_name}"
    puts "File lib/#{file_name} already exists, will not overwrite. Delete it and run the command again if you wish to replace."
  else
    FileUtils.cp "#{gem_dir}/jruby-slick/template/example_game_state.rb", "lib/#{file_name}"
    text = IO.read("lib/#{file_name}")
    IO.write("lib/#{file_name}", text.gsub("ExampleGameState", class_name))
    puts "Created file lib/#{file_name}"
  end
end
