# frozen_string_literal: true

require 'yaml'
require 'pry'

MONTHS_YEAR = 12.0
PERCENT_DIVISOR = 100.0

TERMINAL_TXT = YAML.load_file('mortage_texts.yml')

def prompt_user(prompt)
  puts prompt
  print '> '
  gets.chomp.strip
end

def format_number(n)
  n > n.to_i ? n.truncate(2) : n.to_i
end

def num_input?(s)
  # Ignores the first plus or negative sign of the number.
  s = s[1..-1] if s.start_with?('-', '+')
  split_string = s.split('.')

  # First ensures empty strings are invalid.
  # Secondly, ensures that there are no more than one singular decimal.
  if split_string.empty? || split_string.length > 2
    return false
  end

  # Ensures all characters of the string
  # are numbers. Returns false if a character
  # is outside of the string numbers range.
  split_string.each do |str|
    str.each_char do |c|
      return false unless ('0'..'9').include?(c)
    end
  end

  true
end

def less_decimals?(s, places = 0)
  # String numbers with decimals, should not have more
  # than X number of places. Otherwise, return false.
  # To be used after validating that the input is
  # a number at all.
  valid_decimal = true
  decimal_place = s.index('.')
  if decimal_place && (s[decimal_place..-1].length - 1) > places
    valid_decimal = false
  end

  valid_decimal
end

def remove_usd_prefix!(s)
  dollar_index = s.index('$')

  # Only remove it if the dollar sign is at
  # the beginning of the string. + 1 index, to account for
  # '-$' and '+$'
  if dollar_index && dollar_index <= 1
    s[dollar_index] = ''
  end
end

def clear_screen
  # Utilizes system to clear terminal,
  # otherwise uses dashes and a newline to clear space
  # if command fails.
  unless system('clear')
    puts "----------\n "
  end
end

def divide_screen
  puts " \n----------"
end

def error_message(message = 'Unknown error!')
  puts "[ERROR]: #{message}"
end

def get_num(prompt = 'Give me a number.', expected_type = '', &validation_block)
  loop do
    response = prompt_user(prompt)
    remove_usd_prefix!(response) if expected_type == 'usd'
    response.delete_suffix!('%') if expected_type == 'percent'

    error = num_input?(user_response) ? nil : TERMINAL_TXT['number_error']

    if validation_block
      error = validation_block.call(response)
    end

    if error
      error_message(error)
    else
      return response.to_f
    end
  end
end

def get_rate_type
  loop do
    response = prompt_user(TERMINAL_TXT['rate_type_ask']).downcase
    confirmation = TERMINAL_TXT['rate_replies'][response]
    if confirmation
      puts "\n#{confirmation}"
      return response
    end

    error_message(TERMINAL_TXT['choice_error'])
  end
end

def calc_month_payment(loan_amount, loan_months, rate_type, rate)
  pay = 0
  if rate_type == 'none' || rate == 0
    pay = loan_amount / loan_months
  else
    monthly_rate = rate
    if rate_type == 'apr'
      monthly_rate /= MONTHS_YEAR
    end

    monthly_rate /= PERCENT_DIVISOR
    pay = loan_amount * (monthly_rate / (1 - ((1 + monthly_rate)**(-loan_months))))
  end

  pay
end

def loan_calculator
  clear_screen
  puts TERMINAL_TXT['welcome']

  divide_screen
  loan_amount = get_num(TERMINAL_TXT['loan_ask']) do |user_response|
    if !less_decimals?(user_response, 2)
      TERMINAL_TXT['decimal_error']
    elsif user_response.to_i <= 0
      TERMINAL_TXT['loan_zero_error']
    end
  end
  
  divide_screen
  loan_months = get_num(TERMINAL_TXT['term_ask']) do |user_response|
    if !less_decimals?(user_response, 0)
      TERMINAL_TXT['decimal_error']
    elsif user_response.to_i <= 0
      TERMINAL_TXT['term_zero_error']
    end
  end

  divide_screen
  rate_type = get_rate_type

  rate_percent = 0.0
  unless rate_type == 'none'
    divide_screen
    correct_prompt = TERMINAL_TXT["#{rate_type}_ask"]
    rate_percent = get_number(correct_prompt, 'Rate')
  end
  
  divide_screen
  puts "Your monthly payment comes out to $#{calc_month_payment(loan_amount, loan_months, rate_type, rate_percent)}"

  divide_screen
end

loan_calculator
