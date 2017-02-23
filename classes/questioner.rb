# Job of the Questioner is to ask and store questions

class Questioner

 def initialize(questions)
   @questions = questions
 end

 attr_accessor :questions

 def ask(progress_bar)
   answers = []
   progress_bar.current_step = 1
   @questions.each do |question|
    system("clear")
    puts "#{progress_bar.title}: #{progress_bar.current_step}"
    puts question

    #Where does this STDIN come from?
    answer = STDIN.noecho(&:gets).chomp
    answers << answer
    progress_bar.current_step = progress_bar.current_step + 1
   end
   answers
 end
end