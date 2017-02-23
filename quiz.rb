require 'io/console'
require 'terminal-table'
require 'paint'
require 'CSV'
require 'catpix'
require 'net/http'
require_relative 'classes/progress'
require_relative 'classes/questioner'
require_relative 'classes/data_bot'



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

ans_title = [
  :q_romantic,
  :q_dqueen,
  :q_married,
  :q_phobia,
  :q_accident,
  :q_stupidity,
  :q_fall
]

# CHANGE THIS TO NEW SHEET ID
sheet_id = "https://docs.google.com/spreadsheets/d/1xBdgF6qNQWKdcydvA3PCyLJ5xFXzTmqwuqw1yyoiZfA/pub?gid=465771967&single=true&output=csv"

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

d_bot1 = DataBot.new(sheet_id)
data = d_bot1.get_data

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


# Array that stores count for jamie and trent votes

ans[:q_romantic] = d_bot1.count_data(ans[:q_romantic])
ans[:q_dqueen] = d_bot1.count_data(ans[:q_dqueen])
ans[:q_married] = d_bot1.count_data(ans[:q_married])
ans[:q_phobia] = d_bot1.count_data(ans[:q_phobia])
ans[:q_accident] = d_bot1.count_data(ans[:q_accident])
ans[:q_stupidity] = d_bot1.count_data(ans[:q_stupidity])
ans[:q_fall] = d_bot1.count_data(ans[:q_fall]) # 7 20


# Loop through things
i = 0
q.each do |category|
  puts "#{q_list[i]}:"
  puts "Jamie: #{ans[ans_title[i]][0]}"
  puts "Trent: #{ans[ans_title[i]][1]}"
  i += 1
end


# print_face(ans_dqueen[2])



