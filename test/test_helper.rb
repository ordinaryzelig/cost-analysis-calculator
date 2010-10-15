$LOAD_PATH.unshift '.'
require 'init'
require 'minitest/unit'
MiniTest::Unit.autorun

class MiniTest::Unit::TestCase

  def self.test(name, &block)
    define_method "test #{name}", &block
  end

end
