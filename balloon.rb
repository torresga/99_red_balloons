class Balloon
	attr_reader :x, :y

	def initialize(window)
		@image = Gosu::Image.new(window, "balloon.png", false)
		@x = rand * 640
		@y = rand * 480
	end

	def draw
		@image.draw(@x, @y, 1, 1, 1)
	end
end