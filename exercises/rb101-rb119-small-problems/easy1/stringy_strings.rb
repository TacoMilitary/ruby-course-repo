# frozen_string_literal: true

def stringy(str_length = 1)
  alternating_string = ''

  str_length = 1 if str_length <= 0
  str_length.times do |n|
    alternating_string += ((n + 1) % 2).to_s
  end

  alternating_string
end

puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7) == '1010101'
puts stringy(3)
