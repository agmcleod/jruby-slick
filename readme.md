# jruby-slick
A simple gem to download and unpack the dependencies for making a slick game.

**Note** Slick2d to my knowledge is no longer maintained. I have to admit getting this gem to work on Windows & Linux has not been a successful endeavour. If you do wish to still use JRuby for games, try using LibGDX instead. I've messed with it a bit, but I'm still not sure of the best way to distribute cross platform. There might be some tools out there, as it's been months since i've looked. I'm still open to accepting patches for this gem, but I doubt I'll ever work on it, given I mostly code my games using HTML5.

## Installation

    gem install jruby-slick

## Usage

Install the slick dependencies into a vendor/ directory:

    jruby-slick.rb install

This will download the dependencies required. To run the example file, simply run it:

    cd bin
    jruby example.rb


**Generate an example gamestate**
Creates the file lib/example_game_state.rb, with ExampleGameState class

    jruby-slick.rb gamestate

Creates the file lib/play_game_state.rb, with PlayGameState class

    jruby-slick.rb gamestate play
