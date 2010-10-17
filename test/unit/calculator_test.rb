require 'test_helper'

class CalculatorTest < MiniTest::Unit::TestCase

  test 'questions returns array of questions from file' do
    questions = Calculator.new.questions
    assert questions.all? { |q| q.is_a?(Question) }
  end

  test 'question turns into method that returns question' do
    calc = Calculator.new
    question_name = 'asdf'
    question = Question.new(question_name, '', '')
    calc.send(:define_question, question)
    assert calc.respond_to?(question_name)
    assert_equal question, calc.send(question_name)
  end

  test 'question answer can refer to other question' do
    calc = Calculator.new
    q1 = Question.new('q1', 'question 1', '1')
    q2 = Question.new('q2', 'question 2', 'q1 + q1')
    [q1, q2].each { |question| calc.send(:define_question, question) }
    assert_equal 2, calc.q2.answer
  end

  test 'new calculator defines methods for attributes sent at instantiation' do
    calc = Calculator.new(:new_method => 1)
    assert_equal 1, calc.new_method
  end

  test 'questions loaded properly and extend with answer method' do
    calc = Calculator.new
    question = calc.questions.first
    assert calc.respond_to?(question.name)
    assert question.respond_to?(:answer)
  end

end
