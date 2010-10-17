require 'test_helper'

class QuestionTest < TestHelper

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

  test 'pretty returns formatted string of answer' do
    calc = Calculator.new
    ['currency', 'percentage', 'note'].each do |display_type|
      q = Question.new(display_type, '', '1', display_type)
      calc.send(:define_question, q)
    end
    assert_equal '$1.00', calc.currency.pretty
    assert_equal '1%', calc.percentage.pretty
    assert_equal '', calc.note.pretty
  end

end
