require 'erb'

class Calculator

  # define attribute accessors for each key.
  # set value.
  def initialize(atts = {})
    atts.each do |key, val|
      self.class.send(:attr_accessor, key) unless respond_to?(key)
      send("#{key}=", val)
    end
  end

  def questions
    @questions ||= load_questions
  end

  private

  def load_questions
    YAML.load_file(File.join(ROOT_PATH, 'questions.yml')).map do |name, atts|
      question = Question.new(name, atts['display_name'], atts['answer_string'], atts['type'])
      define_question(question)
      question
    end
  end

  # Define method with quesiton name as method name.
  # Method will return question.
  # Also, define answer method on question.
  def define_question(question)
    self.class.send(:define_method, question.name) do
      question
    end
    define_answer_method_on(question)
  end

  # Question will have :answer method defined with current binding.
  # Binding will allow question.answer refer to calculator methods including other questions.
  # answer_string will be ready for erb interpretation.
  # eval the resulting string.
  # whew!
  def define_answer_method_on(question)
    b = binding
    question.define_singleton_method :answer do
      begin
        erb_result = ERB.new(formatted_answer_string).result(b)
        eval erb_result, b
      rescue NameError => name_ex
        raise "Don't recognize '#{name_ex.name}' in '#{question.answer_string}'. Perhaps you misspelled it?"
      rescue Exception => ex
        puts ex.inspect
        puts question.formatted_answer_string
        puts erb_result.inspect
        raise "something went wrong with #{question.name}: #{question.answer_string} (#{ex.class})"
      end
    end
  end

end
