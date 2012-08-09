require 'net/http'
require 'fileutils'
require 'rubygems'
require 'zip/zipfilesystem'
require 'rbconfig'
desc 'Download Slick Distribution'

task :download_slick do

  FileUtils.rm_rf "vendor/slick"
  FileUtils.mkdir_p "vendor/slick"

  res = Net::HTTP.get_response(URI("http://slick.cokeandcode.com/downloads/slick.zip"))
  File.open("temp.zip", "w+") do |f|
    f.write(res.body)
  end
  Zip::ZipFile.open("temp.zip") do |zipfile|
    zipfile.each do |entry|
      if entry.file? && /^lib\// =~ entry.name
        entry.extract entry.to_s.gsub(/^lib/, "vendor/slick")
      end
    end
  end
  File.delete("temp.zip")
end

task :setup_natives do
  FileUtils.mkdir_p "bin" unless File.exists? "bin"
  target = RbConfig::CONFIG['target_os'].downcase
  platform = ''
  if target.index('mswin')
    platform = 'mingw'
  elsif target.index('darwin')
    platform = 'mac'
  elsif target.index('linux')
    platform = 'linux'
  end

  Dir['vendor/slick/*.jar'].each do |jar_file|
    if jar_file.index('natives-') && jar_file.gsub('vendor/slick/natives-', '').gsub('.jar', '') == platform
      Zip::ZipFile.open(jar_file) do |natives|
        natives.each do |f|
          path = "bin/#{f.to_s}"
          File.delete path if File.exists? path
          f.extract "bin/#{f.to_s}"
        end
      end
    end
  end
end

task :build_example do
  gem_dir = Gem::Specification.find_by_name("jruby-slick").gem_dir

  unless File.exists? "bin/example.rb"
    FileUtils.cp "#{gem_dir}/jruby-slick/template/example.rb", "bin/example.rb"
  end
end