class Calculator

  attr_reader :number_of_doctors_in_your_practice, :yearly_practice_receivables

  def initialize(atts = {})
    atts.each do |key, val|
      self.class.send(:define_method, key.to_sym) { val }
    end
  end

  def questions
    @questions || load_questions
  end

  private

  def load_questions
    require 'yaml'
    YAML.load_file(ROOT_PATH + '/questions.yml').map do |name, atts|
      Question.new(name, atts[:display], atts[:answer_proc])
    end
  end

  def define_question(question)
    self.class.send(:define_method, question.name) do
      b = binding
      question.define_singleton_method :answer do
        eval answer_string, b
      end
      question
    end
  end

end
