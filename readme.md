# jruby-slick
A simple gem to download and unpack the dependencies for making a slick game.

## Installation

    gem install jruby-slick

### Windows
While the gem works, the download I grab from slick's website does not contain the native files for windows 64 bit. If you're running windows 64 bit, download the lwjgl distribution from lwjgl.org, and put the 64 bit ones from there in the directory. Be sure to delete the 32 bit ones in your folder. I'll work on a fix for this eventually.

## Usage

Install the slick dependencies into a vendor/ directory:

    jruby-slick.rb install


**Generate an example gamestate**
Creates the file lib/example_game_state.rb, with ExampleGameState class

    jruby-slick.rb gamestate

Creates the file lib/play_game_state.rb, with PlayGameState class

    jruby-slick.rb gamestate play
