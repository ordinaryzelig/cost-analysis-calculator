require './init'
enable :run if $0 == __FILE__
set :haml, :format => :html5

get '/' do
  defaults = [
    [3, 500_000,  1, 0.0783],
    [2, 700_000,  1, 0.07],
    [5, 3_500_00, 3, 0.065]
  ]
  @calculators = defaults.map do |number_of_doctors_in_your_practice, yearly_practice_receivables, number_of_billing_personnel, billing_service_fee_for_full_service|
    Calculator.new(
      :number_of_doctors_in_your_practice => number_of_doctors_in_your_practice,
      :yearly_practice_receivables => yearly_practice_receivables,
      :number_of_billing_personnel => number_of_billing_personnel,
      :billing_service_fee_for_full_service => billing_service_fee_for_full_service
    )
  end
  @calculators.each(&:questions) # load questions.
  haml :index
end

post '/' do
  @calculators = params[:calculators].map do |i, param|
    Calculator.new(param)
  end
  @calculators.each(&:questions) # load questions.
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
    "<label>#{field.to_s.gsub('_', ' ').capitalize}</label>"
  end

  def text_field_for(field, index, calculator)
    "<input type=\"text\" id=\"#{field}_#{index}\" name=\"calculators[#{index}][#{field}]\" value=\"#{calculator.try(field)}\" size=\"20\" />"
  end

  def input_row_for(field)
    tr('class="input"') do
      <<-END
#{th label_for(field)}
#{@calculators.each_with_index.map { |calc, i| td(text_field_for(field, i, calc)) }.join("\n") }
      END
    end
  end

  def question_row(field)
    questions = @calculators.map(&field)
    display_type = questions.first.display_type
    tr("class=\"#{display_type}\"") do
      <<-END
#{th questions.first.display_name}
#{questions.map { |question| td(question.pretty, 'class="answerCell"') }.join("\n")}
      END
    end
  end

  def tr(options = nil)
    <<-END
<tr #{options}>
#{yield}
</tr>
    END
  end

  def th(content, options = nil)
    "<th #{options}>#{content}</th>"
  end

  def td(content, options = nil)
    "<td #{options}>#{content}</td>"
  end

  def divider_row
    tr('class="dividerRow"') { td('&nbsp;', "colspan=\"#{@calculators.size + 1}\"") }
  end

  private

  def cached_url(url, file_path)
    url + '?' + File.mtime(File.join(Sinatra::Application.views, file_path)).to_i.to_s
  end

end
