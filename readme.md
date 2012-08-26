# jruby-slick
A simple gem to download and unpack the dependencies for making a slick game. When you install the gem, simply run jruby-slick.rb wherever you wish to download the files, and it will put them into a vendor/slick directory.

## Installation

    gem install jruby-slick --pre

### Windows
While the gem works, the download I grab from slick's website does not contain the native files for windows 64 bit. If you're running windows 64 bit, download the lwjgl distribution from lwjgl.org, and put the 64 bit ones from there in the directory. Be sure to delete the 32 bit ones in your folder. I'll work on a fix for this eventually.
