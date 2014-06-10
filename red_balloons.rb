require 'rubygems'
require 'gosu'

load 'player.rb'
load 'balloon.rb'

# * 1. Create new window with sky background
# * 2. Get balloons to show up on the screen randomly
# * 3. Get Zeppelin on the screen - zeppelin needs to be smaller and ends need to be transparent
# * 4. Get Zeppelin to move around
# 5. Get balloons to randomly disappear in 10 seconds
# * 6. Put balloon counter in top middle of screen. Every time you catch a balloon, the counter increases.
# 7. Put timer in top right corner of screen.
# 8. After sixty seconds, if player has not caught 99 balloons, they lost. If player caught 99 balloons they win.
# 9. Play 99 red balloons.

# change functionality of keys.. key up moves zeppelin up, key down moves zeppelin down, key right moves zeppelin right, key left moves zeppelin left
# * Animation... balloon disappears? then a new balloon is created?
# * when player crashes into balloon, balloon disappears



class Window < Gosu::Window
	def initialize
		super(640, 480, false)
		self.caption = "99 Red Balloons"

		@background_image = Gosu::Image.new(self, "sky.jpg", true)
		@player = Player.new(self)
		@balloons = Array.new
		@font = Gosu::Font.new(self, Gosu::default_font_name, 20)
	end

	def update
		# THIS CONTAINS MAIN GAME LOGIC
		if button_down? Gosu::KbLeft
			@player.turn_left
		elsif button_down? Gosu::KbRight
			@player.turn_right
		elsif button_down? Gosu::KbUp or button_down? Gosu::KbDown then
			@player.accelerate
		end

		@player.move

		@player.collect_balloons(@balloons)

		if @balloons.length < 25
			@balloons << Balloon.new(self)
		end


		if @player.count >= 99
			@font.draw("YOU WIN", 100, 100, 1.0, 1.0, 1.0, 0xffffff00)
		end

	end

	def draw
		@background_image.draw(0, 0, 0)
		@player.draw
		@balloons.each { |balloon| balloon.draw }
		@font.draw("Score: #{@player.count}", 10, 10, 1.0, 1.0, 1.0, 0xffffff00)
	end

end

window = Window.new
window.show