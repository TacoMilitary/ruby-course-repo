# frozen_string_literal: true

LOAN_PRINCIPAL_PROMPT = 'How much is your Loan Principal?'
LOAN_TERM_PROMPT = 'How many months is your Loan Term?'
INTEREST_APR_PROMPT = <<-HEREDOC
Will we be using an Interest Rate or an APR?
 (interest)?
 (apr)?
HEREDOC

APR_PROMPT = 'What is the your APR? (%)'
INTEREST_PROMPT = 'What is your Interest Rate? (%)'

DEFAULT_RATE_RESPONSE = "Okay, so we're not including any Rates."
RATE_RESPONSES = {
  'interest' => "So we're working with Interest Rate.",
  'apr' => "So we're using the Annual Percentage Rate."
}

def prompt_user(prompt)
  puts prompt
  print '> '
  gets.chomp
end

def format_number(n)
  n > n.to_i ? n.truncate(2) : n.to_i
end

def loan_calculator
  puts 'Hello! Welcome the mortage calculator!'
  
  loan_p = prompt_user(LOAN_PRINCIPAL_PROMPT).to_f
  loan_months = prompt_user(LOAN_TERM_PROMPT).to_f

  rate_response = prompt_user(INTEREST_APR_PROMPT).downcase.strip
  rate_confirmation_reply = RATE_RESPONSES[rate_response] || DEFAULT_RATE_RESPONSE
  puts "#{rate_confirmation_reply}\n"

  monthly_rate = 0.0
  final_monthly = 0.0
  if rate_confirmation_reply == DEFAULT_RATE_RESPONSE
    final_monthly = loan_p / loan_months
  else
    if rate_response == 'apr'
      monthly_rate = prompt_user(APR_PROMPT).to_f / 12.0
    else
      monthly_rate = prompt_user(INTEREST_PROMPT).to_f
    end
    monthly_rate /= 100
    final_monthly = loan_p * (monthly_rate / (1 - ((1 + monthly_rate)**(-loan_months))))
  end

  puts "Your monthly payment comes out to $#{format_number(final_monthly)}."
end

loan_calculator
