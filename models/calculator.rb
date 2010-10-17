require 'erb'

class Calculator

  # define attribute accessors for each key.
  # set value.
  def initialize(atts = {})
    atts.each do |key, val|
      attr(:accessor, key, val)
    end
  end

  def questions
    @questions ||= load_questions
  end

  def get_binding
    binding
  end

  private

  def load_questions
    YAML.load_file(File.join(ROOT_PATH, 'questions.yml')).map do |name, atts|
      question = Question.new(name, atts['display_name'], atts['answer_string'], atts['display_type'])
      define_question(question)
      question
    end
  end

  # Define method with quesiton name as method name.
  # Method will return question.
  # Also, define answer method on question.
  def define_question(question)
    question.calculator = self
    attr(:reader, question.name, question)
  end

  def attr(type, name, initial_value)
    self.class.send(:"attr_#{type}", name) unless respond_to?(name)
    instance_variable_set :"@#{name}", initial_value
  end

end
