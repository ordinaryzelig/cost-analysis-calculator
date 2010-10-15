class Question

  attr_reader :name, :display_name, :answer_string

  def initialize(*atts)
    @name, @display_name, @answer_string = atts
    @answer_string = self.class.format_string(@answer_string)
  end

  def self.format_string(string)
    return '' unless string
    string = string.split.map do |token|
      if token[0] == '='
        token[1..-1] + '.answer'
      else
        token
      end
    end.join(' ')
  end

end
