# frozen_string_literal: true

require 'yaml'
require 'pry'

MONTHS_YEAR = 12.0

TERMINAL_TXT = YAML.load_file('mortage_texts.yml')

def prompt_user(prompt)
  puts prompt
  print '> '
  gets.chomp
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
  # are numbers.
  split_string.each do |str|
    str.each_char do |c|
      return false unless ('0'..'9').include?(c)
    end
  end

  true
end

def two_decimal_input?(s)
  # Numbers with decimals, should not have more than two places.
  # Otherwise, return false. To be used after validating
  # that the input is a number at all.
  valid_decimal = true
  decimal_place = s.index('.')
  if decimal_place && s[decimal_place..-1].length > 3
    valid_decimal = false
  end

  valid_decimal
end

def remove_usd_prefix!(s)
  possible_prefixes = %w(-$ $ +$)
  possible_prefixes.each do |pre|
    s.delete_prefix!(pre)
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

def get_loan_amount
  loop do
    valid = true
    error = nil

    response = prompt_user(TERMINAL_TXT['loan_ask'])
    # If users input a dollar sign it will be cleaned.
    remove_usd_prefix!(response)

    unless num_input?(response) && two_decimal_input?(response)
      valid = false
      error ||= '[ERROR]: This is not a valid number!'
    end

    unless response.to_i > 0
      valid = false
      error ||= '[ERROR]: Loan must be greater than zero.'
    end

    puts error if error
    return response.to_f if valid
  end
end

def get_loan_months
  
end

def loan_calculator
  clear_screen
  puts TERMINAL_TXT['welcome']

  loan_p = get_loan_amount
  loan_months = prompt_user(TERMINAL_TXT['term_ask']).to_f

  rate_response = prompt_user(TERMINAL_TXT['rate_type_ask']).downcase.strip
  rate_confirmation_reply = RATE_RESPONSES[rate_response] || DEFAULT_RATE_RESPONSE
  puts "#{rate_confirmation_reply}\n"

  monthly_rate = 0.0
  final_monthly = 0.0
  if rate_confirmation_reply == DEFAULT_RATE_RESPONSE
    final_monthly = loan_p / loan_months
  else
    if rate_response == 'apr'
      monthly_rate = prompt_user(APR_PROMPT).to_f / MONTHS_YEAR
    else
      monthly_rate = prompt_user(INTEREST_PROMPT).to_f
    end
    monthly_rate /= 100
    final_monthly = loan_p * (monthly_rate / (1 - ((1 + monthly_rate)**(-loan_months))))
  end

  puts "Your monthly payment comes out to $#{format_number(final_monthly)}."
end

loan_calculator
