$:.push File.expand_path('../../vendor/slick', __FILE__)

require 'java'
require 'lwjgl.jar'
require 'slick.jar'

java_import org.newdawn.slick.AppGameContainer
java_import org.newdawn.slick.GameContainer
java_import org.newdawn.slick.Graphics
java_import org.newdawn.slick.Image
java_import org.newdawn.slick.SlickException
java_import org.newdawn.slick.Input
java_import org.newdawn.slick.state.StateBasedGame

class ExampleGame < StateBasedGame
  def initialize
    super "Example Slick2d"
  end

  def initStatesList(gc)
  end
end

app = AppGameContainer.new(ExampleGame.new)
app.setDisplayMode(GunzABlazin.width, GunzABlazin.height, false)
app.start()