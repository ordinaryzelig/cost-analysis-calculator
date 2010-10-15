require 'test_helper'

class QuestionTest < MiniTest::Unit::TestCase

  test 'format sting replaces =token with token.answer' do
    string = '=asdf + =qwer'
    result = 'asdf.answer + qwer.answer'
    assert_equal result, Question.format_string(string)
  end
end
