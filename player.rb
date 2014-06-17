class Player
	attr_accessor :x, :y

	def initialize(window)
		@image = Gosu::Image.new(window, "zeppelin_game.png", false)
		@x = @y = 200
		@vel_x = @vel_y = @angle = 0.0
		@count = 0
	end

	def accelerate_up
		@vel_x += Gosu::offset_x(@angle, 0.5)
		@vel_y += Gosu::offset_y(@angle, 0.5)
	end

	def accelerate_right
		@vel_x += Gosu::offset_x(90.0, 0.5)
		@vel_y += Gosu::offset_y(90.0, 0.5)
	end

	def accelerate_left
		@vel_x -= Gosu::offset_x(90.0, 0.5)
		@vel_y -= Gosu::offset_y(90.0, 0.5)
	end


	def accelerate_down
		@vel_x -= Gosu::offset_x(@angle, 0.5)
		@vel_y -= Gosu::offset_y(@angle, 0.5)
	end

	def move
		@x += @vel_x
		@y += @vel_y
		@x %= 640
		@y %= 480

		@vel_x *= 0.95
		@vel_y *= 0.95
	end

	def draw
		@image.draw_rot(@x, @y, 1, @angle)
	end

	def count
		@count
	end

	def collect_balloons(balloons)
		balloons.reject! do |balloon|
			if Gosu::distance(balloon.x, balloon.y, @x, @y) < 35 then
				@count += 1
			end
		end  
	end

end
