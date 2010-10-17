$LOAD_PATH.unshift '.'
require 'init'
require 'test/unit'

class TestHelper < Test::Unit::TestCase

  def self.test(name, &block)
    define_method "test #{name}", &block
  end

  undef :default_test

end
