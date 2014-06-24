require 'rubygems'
require 'gosu'

load 'player.rb'
load 'balloon.rb'

class Window < Gosu::Window

	def initialize
		super(640, 480, false)
		self.caption = "99 Red Balloons"

		@background_image = Gosu::Image.new(self, "background.jpg", true)
		@player = Player.new(self)
		@balloons = Array.new
		@font = Gosu::Font.new(self, Gosu::default_font_name, 50)
	end

	def update

		# THIS CONTAINS MAIN GAME LOGIC
		if button_down? Gosu::KbLeft
			@player.accelerate_left
		elsif button_down? Gosu::KbRight
			@player.accelerate_right
		elsif button_down? Gosu::KbUp
			@player.accelerate_up
		elsif button_down? Gosu::KbDown
			@player.accelerate_down
		end

		@player.move


		@player.collect_balloons(@balloons)

		if @balloons.length < 25
			@balloons << Balloon.new(self)
		end

	end

	def draw
		@background_image.draw(0, 0, 0)
		@player.draw
		@balloons.each { |balloon| balloon.draw }
		@font.draw("#{Gosu::milliseconds/1000}", 320, 10, 1.0, 1.0, 1.0, 0xffffff00)
		@font.draw("Score: #{@player.count}", 10, 10, 1.0, 1.0, 1.0, 0xffffff00)

		if @player.count >= 99
			@font.draw("YOU WIN", 260, 240, 1.0, 1.0, 1.0, 0xffffff00)
		end

		if Gosu::milliseconds/1000 >= 60 and @player.count < 99
			@font.draw("GAME OVER", 260, 240, 1.0, 1.0, 1.0, 0xffffff00)
		end

	end

end

window = Window.new
window.show