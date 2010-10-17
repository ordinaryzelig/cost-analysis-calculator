class Question

  attr_reader :name, :display_name, :answer_string, :formatted_answer_string, :type

  def initialize(*args)
    @name, @display_name, @answer_string, @type = args
    @formatted_answer_string = self.class.format_for_erb(@answer_string)
    require_args
  end

  def to_s
    answer.to_s
  end

  def currency?
    type == 'currency'
  end

  # answer() is defined as a singleton class in question.define_question().

  def self.format_for_erb(string)
    string.split.map do |token|
      if token.match(/[a-zA-Z]+/)
        '<%= ' + token + ' %>'
      else
        token
      end
    end.join(' ')
  end

  private

  def require_args
    raise ArgumentError.new('name, display_name, and answer_string are all required to create a question.') unless name && display_name && answer_string
  end

end
