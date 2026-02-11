# frozen_string_literal: true

def center_of(str = '')
  str_length = str.length
  center_idx = (str_length - 1) / 2
  str_length.odd? ? str[center_idx] : str[center_idx..(center_idx + 1)]
end

puts center_of('I love Ruby') == 'e'
puts center_of('Launch School') == ' '
puts center_of('Launch') == 'un'
puts center_of('Launchschool') == 'hs'
puts center_of('x') == 'x'