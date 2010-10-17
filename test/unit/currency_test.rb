require 'test_helper'

class CurrencyTest < MiniTest::Unit::TestCase

  test '1.0 = $1.00' do
    assert_equal '$1.00', 1.0.to_currency
  end

  test '1 = $1.00' do
    assert_equal '$1.00', 1.to_currency
  end

  test '1000 = $1,000' do
    assert_equal '$1,000.00', 1000.to_currency
  end

  test '100000 = $1,000,000.00' do
    assert_equal '$1,000,000.00', 1_000_000.to_currency
  end

  test '-1 = -$1.00' do
    assert_equal '-$1.00', -1.to_currency
  end

  test '100_000 = $100,000.00' do
    assert_equal '$100,000.00', 100_000.to_currency
  end

end
