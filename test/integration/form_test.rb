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

  test 'site starts with table with defaults' do
    visit '/'
    ['$53,326.00', '$65,976.00', '$125,303.00'].each do |annual_change_in_net_cash_flow|
      assert_contain annual_change_in_net_cash_flow
    end
  end

  test 'form submission' do
    visit "/"
    3.times do |i|
      fill_in "number_of_doctors_in_your_practice_#{i}", :with => i
      fill_in "yearly_practice_receivables_#{i}", :with => (i + 1) * 100
      fill_in "number_of_billing_personnel_#{i}", :with => i + 1
    end
    click_button 'Recalculate'
    ['$36,229.42', '$72,460.50', '$108,692.25'].each do |annual_change_in_net_cash_flow|
      assert_contain annual_change_in_net_cash_flow
    end
  end

end

