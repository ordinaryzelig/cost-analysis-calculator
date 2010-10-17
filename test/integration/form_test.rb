require 'test_helper'
require "rack/test"
require "webrat"
require 'app'

Webrat.configure do |config|
  config.mode = :rack
end

class AppTest < MiniTest::Unit::TestCase

  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  def app
    Sinatra::Application.new
  end

  test 'form submission' do
    visit "/"
    fill_in 'Number of doctors in your practice', :with => 5
    fill_in 'Yearly practice receivables', :with => 3_500_000
    click_button 'Calculate'
    assert_contain '$274,928.00'
  end

end

