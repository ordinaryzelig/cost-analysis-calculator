require 'test_helper'

class QuestionTest < MiniTest::Unit::TestCase

  test 'wrap answer_string words with <%= erb tags %>}' do
    question = Question.new('', '', 'asdf + qwer')
    result = '<%= asdf %> + <%= qwer %>'
    assert_equal result, question.formatted_answer_string
  end

  test 'to_s returns string version of answer' do
    calc = Calculator.new
    q = Question.new('asdf', 'asdf', '1')
    calc.send(:define_question, q)
    assert_equal '1', q.to_s
  end

end
