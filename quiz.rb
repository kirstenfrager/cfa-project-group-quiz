require 'io/console'
require 'terminal-table'
require 'paint'
require 'CSV'
require 'catpix'
require 'net/http'
require_relative 'classes/progress'
require_relative 'classes/questioner'



# Set variables
# List of questions to ask Jamie and Trent
q_list = [
  "Who is most likely to watch romantic movies?",
  "Who is most likely to be a drama queen?",
  "Who is most likely to get married first?",
  "Who is most likely to have weird phobias?",
  "Who is most likely to accidentally kill someone?",
  "Who is most likely to die of something stupid?",
  "Who is most likely to fall whilst walking?"
  ]

# Names of questions for reference
q = ["Romantic", 
     "Drama Queen", 
     "Married", 
     "Phobia", 
     "Accident", 
     "Stupidity", 
     "Fall"]

# declare arrays to store answers for each question
ans = {
  :q_romantic => [],
  :q_dqueen => [],
  :q_married => [],
  :q_phobia => [],
  :q_accident => [],
  :q_stupidity => [],
  :q_fall => []
}


# Method to get data from google sheets
def getData()
  url = "https://docs.google.com/spreadsheets/d/1xBdgF6qNQWKdcydvA3PCyLJ5xFXzTmqwuqw1yyoiZfA/pub?gid=465771967&single=true&output=csv"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  response
end

# Method to calculate how many votes for jamie/trent. Loop through each data array
def tallyPoints(answers)
  count_jamie = 0
  count_trent = 0
  answers.each do |answer|
    if answer == "Jamie"
      count_jamie += 1
    elsif answer == "Trent"
      count_trent += 1
    end
  end
  [count_jamie, count_trent]
end

# Method to print results

def print_face(result)
  
  # Print face for Jamie
  if result == "Trent"
    Catpix::print_image "img/Trent.png",
      :limit_x => 1.0,
      :limit_y => 1,
      :center_x => true,
      :center_y => true,
      :bg => "black",
      :bg_fill => true,
      :resolution => "high"
  # Print face for Trent
  elsif result == "Jamie"
    Catpix::print_image "img/Jamie.png",
      :limit_x => 1.0,
      :limit_y => 1,
      :center_x => true,
      :center_y => true,
      :bg => "black",
      :bg_fill => true,
      :resolution => "high"
  # Print face for Both
  else
    Catpix::print_image "jamie-trent-together.png",
      :limit_x => 1.0,
      :limit_y => 1,
      :center_x => true,
      :center_y => true,
      :bg => "black",
      :bg_fill => true,
      :resolution => "high"
  end
end



# Start program
system "clear"
puts "Trent you're up first! Please answer the following 7 questions with either Trent or Jaime."
puts "Press any key to start"
gets.chomp

# Create new 
quiz = Questioner.new(q_list)
progress = ProgressBar.new("Question")

a_trent = quiz.ask(progress)
a_jamie = quiz.ask(progress)


# Store all answers 
rows = []
rows << ["Romantic Movies", a_trent[0], a_jamie[0]]
rows << ["Drama Queen", a_trent[1], a_jamie[1]]
rows << ["Married First", a_trent[2], a_jamie[2]]
rows << ["Weird Phobias", a_trent[3], a_jamie[3]]
rows << ["Kill Someone", a_trent[4], a_jamie[4]]
rows << ["Dying of Stubidity", a_trent[5], a_jamie[5]]
rows << ["Falling while Walking", a_trent[6], a_jamie[6]]


table = Terminal::Table.new :rows => rows, :title => "TRENT vs JAMIE", :headings => ['Question', "Trent's Answers", "Jamie's Answers"]

system("clear")
puts table


# =============== Working with CSV ===================
# Save data and parse CSV

data = getData()
data = CSV.parse(data)




# For each row of data, append into appropriate array

#IS THIS ADDING ALL ARRAYS INTO EVERY SINGLE ONE????
data.each_with_index do |d, index|
  ans[:q_romantic] << d[1]
  ans[:q_dqueen] << d[2]
  ans[:q_married] << d[3]
  ans[:q_phobia] << d[4]
  ans[:q_accident] << d[5]
  ans[:q_stupidity] << d[6]
  ans[:q_fall] << d[7]
end
# =============== END working with CSV ================


ans[:q_romantic].shift
ans[:q_dqueen].shift
ans[:q_married].shift
ans[:q_phobia].shift
ans[:q_accident].shift
ans[:q_stupidity].shift
ans[:q_fall].shift


#Set the total number of votes into variable
total_votes = ans[:q_accident].count


# Calculate how many votes for jamie/trent. Loop through each data array
# returns array of 2 numbers
def tallyPoints(answers)
  count_jamie = 0
  count_trent = 0
  winner = ""

  answers.each do |answer|
      if answer == "Jamie"
          count_jamie += 1
      elsif answer == "Trent"
          count_trent += 1
      end
  end

  # Add winner name to third element of output array
  if count_jamie == count_trent
    winner = "Tie"
  elsif count_jamie > count_trent
    winner = "Jamie"
  else
    winner = "Trent"
  end

  [count_jamie, count_trent, winner]
end

# Array that stores count for jamie and trent votes
ans_romantic = tallyPoints(ans[:q_romantic])
ans_dqueen = tallyPoints(ans[:q_dqueen])
ans_married = tallyPoints(ans[:q_married])
ans_phobia = tallyPoints(ans[:q_phobia])
ans_accident = tallyPoints(ans[:q_accident])
ans_stupidity = tallyPoints(ans[:q_stupidity])
ans_fall = tallyPoints(ans[:q_fall]) # 7 20

# Potentially unecessary step? Store all counts in final_answers hash
ans_final = {
  :total => total_votes,
  :romantic_jamie => ans_romantic[0],
  :romantic_trent => ans_romantic[1],
  :dqueen_jamie => ans_dqueen[0],
  :dqueen_trent => ans_dqueen[1],
  :married_jamie => ans_married[0],
  :married_trent => ans_married[1],
  :phobia_jamie => ans_phobia[0],
  :phobia_trent => ans_phobia[1],
  :accident_jamie => ans_accident[0],
  :accident_trent => ans_accident[1],
  :stupidity_jamie => ans_stupidity[0],
  :stupidity_trent => ans_stupidity[1],
  :fall_jamie => ans_fall[0],
  :fall_trent => ans_fall[1]
}


# Method to puts percentage
def get_perc(q_name, score_j, score_t, total_votes)
  puts "PERCENTAGE FOR JAMIE #{q_name} = #{(score_j.to_f / total_votes * 100).to_i}%"
  puts "PERCENTAGE FOR TRENT #{q_name} = #{(score_t.to_f / total_votes * 100).to_i}%"
end


get_perc(q[0],ans_final[:romantic_jamie], ans_final[:romantic_trent],ans_final[:total])
get_perc(q[1],ans_final[:dqueen_jamie], ans_final[:dqueen_trent],ans_final[:total])
get_perc(q[2],ans_final[:married_jamie], ans_final[:married_trent],ans_final[:total])
get_perc(q[3],ans_final[:phobia_jamie], ans_final[:phobia_trent],ans_final[:total])
get_perc(q[4],ans_final[:accident_jamie], ans_final[:accident_trent],ans_final[:total])
get_perc(q[5],ans_final[:stupidity_jamie], ans_final[:stupidity_trent],ans_final[:total])
get_perc(q[6],ans_final[:fall_jamie], ans_final[:fall_trent],ans_final[:total])


print_face(ans_dqueen[2])



