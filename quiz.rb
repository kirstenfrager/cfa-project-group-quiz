require 'io/console'
require 'terminal-table'
require 'paint'
require 'CSV'
require 'catpix'
require 'net/http'
require_relative 'classes/progress'
require_relative 'classes/questioner'
require_relative 'classes/data_bot'
require_relative 'classes/textart'




# Set variables
# List of questions to ask Jamie and Trent
q_list = [
  "Who is more likely to burn the house down while cooking?",
  "Who is more likely to go to a Justin Bieber concert?",
  "Who is more likely to run away to join the circus?",
  "Who is most likely to have weird phobias?",
  "Who is more likely to have a secret desire to be a supermodel?",
  "Who is more likely to appear on big brother?",
  "Who is more likely to cause world war?"
  ]


# declare arrays to store answers for each question
ans = {
  :q_cooking => [],
  :q_bieber => [],
  :q_circus => [],
  :q_phobia => [],
  :q_supermodel => [],
  :q_bbrother => [],
  :q_war => []
}

ans_title = [
  :q_cooking,
  :q_bieber,
  :q_circus,
  :q_phobia,
  :q_supermodel,
  :q_bbrother,
  :q_war
]

# CHANGE THIS TO NEW SHEET ID
# sheet_id = "https://docs.google.com/spreadsheets/d/1xBdgF6qNQWKdcydvA3PCyLJ5xFXzTmqwuqw1yyoiZfA/pub?gid=465771967&single=true&output=csv"
sheet_id = "https://docs.google.com/spreadsheets/d/1soTqfzAlTdiJDI_QxFuCLqwnJRh2HYHOwVMXDVzKGkc/pub?gid=372547824&single=true&output=csv"


text_art = TextArt.new
text_art.draw("heading")

# Start program
puts "Press any key to start"
gets.chomp

# Create new 
quiz = Questioner.new(q_list)
progress = ProgressBar.new("Question")


a_trent = quiz.ask(progress, text_art, "trent")

text_art.draw("jamie")

puts "Press any key to start"
gets.chomp

a_jamie = quiz.ask(progress, text_art, "jamie")


# Store all answers 
rows = []
rows << ["Cooking", a_trent[0], a_jamie[0]]
rows << ["Bieber", a_trent[1], a_jamie[1]]
rows << ["Circus", a_trent[2], a_jamie[2]]
rows << ["Weird Phobias", a_trent[3], a_jamie[3]]
rows << ["Supermodel", a_trent[4], a_jamie[4]]
rows << ["Big Brother", a_trent[5], a_jamie[5]]
rows << ["World War", a_trent[6], a_jamie[6]]


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
  ans[:q_cooking] << d[1]
  ans[:q_bieber] << d[2]
  ans[:q_circus] << d[3]
  ans[:q_phobia] << d[4]
  ans[:q_supermodel] << d[5]
  ans[:q_bbrother] << d[6]
  ans[:q_war] << d[7]
end
# =============== END working with CSV ================

ans[:q_cooking].shift
ans[:q_bieber].shift
ans[:q_circus].shift
ans[:q_phobia].shift
ans[:q_supermodel].shift
ans[:q_bbrother].shift
ans[:q_war].shift

# Array that stores count for jamie and trent votes

ans[:q_cooking] = d_bot1.count_data(ans[:q_cooking])
ans[:q_bieber] = d_bot1.count_data(ans[:q_bieber])
ans[:q_circus] = d_bot1.count_data(ans[:q_circus])
ans[:q_phobia] = d_bot1.count_data(ans[:q_phobia])
ans[:q_supermodel] = d_bot1.count_data(ans[:q_supermodel])
ans[:q_bbrother] = d_bot1.count_data(ans[:q_bbrother])
ans[:q_war] = d_bot1.count_data(ans[:q_war]) # 7 20


# Loop and output final results
i = 0
q_list.each do |category|
  puts "#{q_list[i]}:"
  puts "Jamie: #{ans[ans_title[i]][0]}"
  puts "Trent: #{ans[ans_title[i]][1]}"
  i += 1
end

d_bot1.print_face(ans[:q_cooking][2])





