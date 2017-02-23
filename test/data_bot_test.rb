require 'test/unit'
require_relative '../classes/data_bot'

class DataBotTest < Test::Unit::TestCase

	# test that google sheet return data is a String
	def test_get_data_type
		data_bot1 = DataBot.new("https://docs.google.com/spreadsheets/d/1xBdgF6qNQWKdcydvA3PCyLJ5xFXzTmqwuqw1yyoiZfA/pub?gid=465771967&single=true&output=csv")
		actual = data_bot1.get_data.class
		expected = String
		msg = "Data type should be a String"
		assert_equal(actual, expected, msg)
	end

	# test that count_data returns array length is 3
	# def test_count_data_array_length
	# 	data_bot2 = DataBot.new("https://docs.google.com/spreadsheets/d/1xBdgF6qNQWKdcydvA3PCyLJ5xFXzTmqwuqw1yyoiZfA/pub?gid=465771967&single=true&output=csv")
	# 	answer = DataBot.get_data
		
	# end


end
