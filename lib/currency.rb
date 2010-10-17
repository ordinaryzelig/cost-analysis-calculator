require 'bigdecimal'

class Numeric

  def to_currency
    left, right = BigDecimal.new(to_s).round(2).abs.to_f.to_s.split('.')
    # inject commas to left side.
    left = left.reverse.gsub(/(...)/, '\1,').reverse
    left = left[1..-1] if left[/^,/]
    # pad right with 0s if necessary.
    right = right + '0' if right.length == 1
    "#{negative? ? '-' : ''}$#{left}.#{right}"
  end

  def negative?
    self < 0
  end

end
