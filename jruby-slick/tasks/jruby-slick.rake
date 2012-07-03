require 'net/http'
require 'fileutils'
require 'rubygems'
require 'zip/zipfilesystem'
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