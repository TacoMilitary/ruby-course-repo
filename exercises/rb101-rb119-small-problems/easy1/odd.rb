# frozen_string_literal: true

def is_odd?(check_int = 0)
  check_int.abs.odd?
end

puts is_odd?(2)
puts is_odd?(5)
puts is_odd?(-17)
puts is_odd?(-8)
puts is_odd?(0)
puts is_odd?(7)
