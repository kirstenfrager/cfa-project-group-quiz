require 'test/unit'
require_relative '../classes/questioner'
require_relative '../classes/progress'
require_relative '../classes/textart'

class QuestionerTest < Test::Unit::TestCase
 @@questions = ["Who is more likely to burn the house down while cooking?",
  "Who is more likely to go to a Justin Bieber concert?",
  "Who is more likely to run away to join the circus?",
  "Who is more likely to have weird phobias?",
  "Who is more likely to be a supermodel?",
  "Who is more likely to appear on big brother?",
  "Who is more likely to accidentally kill someone?",
  "Who is more likely to cause world war?"]

  @text_art = TextArt.new

 def test_questioner_questions
   quiz = Questioner.new(@@questions)
   assert_equal(@@questions, quiz.questions)
 end
#@@class variable
 def test_questioner_ask_questions
   #progress_bar is an instance of progressbar class
   progress_bar = ProgressBar.new("Hello")
   expected_answers = ["Jamie", "Jamie", "Jamie", "Jamie", "Jamie", "Jamie", "Jamie", "Jamie"]
#quiz is instance of the questioner class
   quiz = Questioner.new(@@questions)
   actual_answers = quiz.ask(progress_bar, @text_art , "jamie")
   assert_equal(expected_answers, actual_answers)
 end
end