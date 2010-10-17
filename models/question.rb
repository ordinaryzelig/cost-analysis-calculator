class Question

  attr_reader :name, :display_name, :answer_string, :formatted_answer_string, :type
  attr_writer :calculator

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

  def answer
    begin
      # Using ERB here so that methods called with have to_s called on them.
      # then eval can do its thing.
      erb_result = ERB.new(formatted_answer_string).result(@calculator.get_binding)
      eval erb_result
    rescue NameError => name_ex
      raise "Didn't recognize '#{name_ex.name}' in definition for #{name}: '#{answer_string}'. Perhaps you misspelled it?"
    rescue Exception => ex
      puts ex.inspect
      puts formatted_answer_string
      puts erb_result.inspect
      raise "something went wrong with #{name}: #{answer_string} (#{ex.class})"
    end
  end

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
