# frozen_string_literal: true

def reversed_number(n = 1)
  n = n.positive? ? n.to_s : '1'
  num_type = n.is_a?(Integer) ? :to_i : :to_f
  n.reverse.public_send(num_type)
end

puts reversed_number(12_345) == 54_321
puts reversed_number(12_213) == 31_221
puts reversed_number(456) == 654
puts reversed_number(12_000) == 21
puts reversed_number(12_003) == 30_021
puts reversed_number(1) == 1
puts reversed_number(12.0037)
