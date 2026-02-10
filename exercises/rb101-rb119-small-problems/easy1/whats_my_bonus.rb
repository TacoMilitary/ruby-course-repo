# frozen_string_literal: true

def calculate_bonus(salary = 0, bonus = false)
  bonus ? salary / 2 : 0
end

puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false).zero?
puts calculate_bonus(50_000, true) == 25_000
