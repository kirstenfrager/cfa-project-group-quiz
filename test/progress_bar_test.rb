require 'test/unit'
require_relative '../classes/progress'

class ProgressBarTest < Test::Unit::TestCase

# testing just need expected and actual
 def test_progress_bar_current_step
   expected = 1
   bar = ProgressBar.new("New Bar") #actual
   assert_equal(expected, bar.current_step)#actual
 end

 def test_progress_bar_title
   bar = ProgressBar.new("My title")
   assert_equal("My title", bar.title)
 end
end