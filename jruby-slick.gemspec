Gem::Specification.new do |s|
  s.name = "jruby-slick"
  s.version = "1.1.1"
  s.platform = "ruby"
  s.authors = ["Aaron McLeod"]
  s.email = ["aaron.g.mcleod@gmail.com"]
  s.homepage = "http://github.com/agmcleod/jruby-slick"
  s.summary = "A command line tool for downloading and unzipping all the basic jar files of the slick2d library."
  s.description = ""
  s.files = Dir.glob("{jruby-slick,bin}/**/*") + %w{.gitignore Rakefile}
  s.require_path = '.'
  s.bindir = 'bin'
  s.executables = ['jruby-slick.rb']
  s.default_executable = 'jruby-slick.rb'
  s.add_dependency 'rubyzip'
  s.add_dependency "rake"
end