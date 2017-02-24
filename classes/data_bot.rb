require 'net/http'

# Databot class is able to:
 # get_data gets google sheet data
 # count_data takes in answers for each questions
 		# tallies votes for trent/jamie
 		# converts into percentage
 		# outputs winner name
 # Prints photo based on winner

class DataBot
	def initialize(url)
		@url = url
		@count_jamie = 0
		@count_trent = 0
		@winner = ""
	end

	attr_accessor :url

	# GOAL: get the mother f data
	def get_data
		uri = URI(@url)
	  response = Net::HTTP.get(uri)
	  response
	end

	# GOAL: tally and count data
	def count_data(answers)
		@count_jamie = 0
	  @count_trent = 0
	  @winner = ""

	  answers.each do |answer|
      if answer == "Jamie"
          @count_jamie += 1
      elsif answer == "Trent"
          @count_trent += 1
      end
	  end

	  total = @count_jamie + @count_trent
	  @count_jamie = (@count_jamie.to_f / total * 100).to_i
	  @count_trent = (@count_trent.to_f / total * 100).to_i

	  # Add winner name to third element of output array
	  if @count_jamie == @count_trent
	    @winner = "Tie"
	  elsif @count_jamie > @count_trent
	    @winner = "Jamie"
	  else
	    @winner = "Trent"
	  end

	  ["#{@count_jamie}%", "#{@count_trent}%", @winner]
	end

	# Method to print results

	def print_face(result)
	  
	  # Print face for Jamie
	  if result == "Trent"
	    Catpix::print_image "img/Trent.png",
	      :limit_x => 1.0,
	      :limit_y => 0,
	      :center_x => true,
	      :center_y => true,
	      :bg => "black",
	      :bg_fill => true,
	      :resolution => "high"
	  # Print face for Trent
	  elsif result == "Jamie"
	    Catpix::print_image "img/Jamie.png",
	      :limit_x => 1.0,
	      :limit_y => 0,
	      :center_x => true,
	      :center_y => true,
	      :bg => "black",
	      :bg_fill => true,
	      :resolution => "high"
	  # Print face for Both
	  else
	    Catpix::print_image "img/Jamie_main.png",
	      :limit_x => 1.0,
	      :limit_y => 0,
	      :center_x => true,
	      :center_y => true,
	      :bg => "black",
	      :bg_fill => true,
	      :resolution => "high"
	  end
	end
end

















# .