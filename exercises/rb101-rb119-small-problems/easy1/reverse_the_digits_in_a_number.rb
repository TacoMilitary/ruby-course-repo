# frozen_string_literal: true

def reversed_number(n = 1)
  n = n.positive? ? n.to_s : "1"
  n.reverse.to_i
end

puts reversed_number(12345) == 54321
puts reversed_number(12213) == 31221
puts reversed_number(456) == 654
puts reversed_number(12000) == 21
puts reversed_number(12003) == 30021
puts reversed_number(1) == 1