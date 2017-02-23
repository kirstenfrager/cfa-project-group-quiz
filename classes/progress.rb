#Job of the progressbar is increment numbers for questions
class ProgressBar
 def initialize(title)
   @current_step = 1
   @title = title
 end
 attr_accessor :current_step, :title
end