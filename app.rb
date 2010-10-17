require './init'
enable :run if $0 == __FILE__
set :haml, :format => :html5

get '/' do
  @calculator = Calculator.new
  haml :index
end

post '/' do
  defaults = {
    :number_of_billing_personnel => 3
  }
  @calculator = Calculator.new(params[:calculator].merge(defaults))
  @calculator.questions # load questions.
  haml :index
end

get '/stylesheets/screen.css' do
  content_type 'text/css', :charset => 'utf-8'
  response['Expires'] = (Time.now + 60*60*24*356*3).httpdate
  sass :'stylesheets/screen'
end

helpers do

  def timestamped_stylesheet_url
    stylesheets_path = 'stylesheets/screen.sass'
    cached_url('stylesheets/screen.css', stylesheets_path)
  end

  def label_for(field)
    "<label for=\"#{field}\">#{field.gsub('_', ' ').capitalize}</label>"
  end

  def text_field_for(field)
    "<input type=\"text\" id=\"#{field}\" name=\"calculator[#{field}]\" value=\"#{@calculator.try(field)}\" size=\"5\" />"
  end

  def input_row_for(field)
    tr do
      <<-END
#{th label_for(field)}
#{td text_field_for(field)}
      END
    end
  end

  def question_row(question)
    tr do
      <<-END
#{th question.display_name}
#{td (question.currency? ? question.answer.to_currency : question.answer)}
      END
    end
  end

  def row_for(th_content, td_content)
    tr do
      <<-END
#{th(th_content)}
#{td(td_content)}
      END
    end
  end

  def tr
    <<-END
<tr>
#{yield}
</tr>
    END
  end

  def th(content = nil)
    "<th>#{block_given? ? yield : content}</th>"
  end

  def td(content = nil)
    "<td>#{block_given? ? yield : content}</td>"
  end

  private

  def cached_url(url, file_path)
    url + '?' + File.mtime(File.join(Sinatra::Application.views, file_path)).to_i.to_s
  end

end
