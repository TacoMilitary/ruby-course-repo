# frozen_string_literal: true

require 'yaml'

PROMPT_TEXTS = YAML.load_file('calculator_texts.yml')

p PROMPT_TEXTS

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num_txt)
  # if the user inputs a string that begins with 0, assume they want to input 0.
  # this mimics the behavior of #to_i such that if you input a number before non-number text
  # it will use the first valid number and ignore the rest of the string
  num_txt.start_with?('0') ? true : num_txt.to_i != 0
end

def operation_to_message(op)
  verb = case op
          when '1'
            'Adding'
          when '2'
            'Subtracting'
          when '3'
            'Multiplying'
          when '4'
            'Dividing'
         end

  verb
end

prompt(PROMPT_TEXTS['intro'])

name = ''
loop do
  name = Kernel.gets().chomp()
  if name.strip().empty?()
    prompt(PROMPT_TEXTS['invalid_name'])
  else
    break
  end
end

prompt("Hi, #{name}!")

loop do
  number1 = ''
  loop do
    prompt(PROMPT_TEXTS['first_num'])
    number1 = Kernel.gets().chomp()
    if valid_number?(number1)
      break
    else
      prompt(PROMPT_TEXTS['invalid_number'])
    end
  end

  number2 = ''
  loop do
    prompt(PROMPT_TEXTS['second_num'])
    number2 = Kernel.gets().chomp()
    if valid_number?(number2)
      break
    else
      prompt(PROMPT_TEXTS['invalid_number'])
    end
  end

  prompt(PROMPT_TEXTS['operator_prompt'])
  operator = ''
  loop do
    operator = Kernel.gets().chomp()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(PROMPT_TEXTS['invalid_operator'])
    end
  end
  
  prompt("#{operation_to_message(operator)} the two numbers...")

  result = case operator
            when '1'
              number1.to_i() + number2.to_i()
            when '2'
              number1.to_i() - number2.to_i()
            when '3'
              number1.to_i() * number2.to_i()
            when '4'
              number1.to_f() / number2.to_f()
           end

  prompt("The result is #{result}")
  
  prompt(PROMPT_TEXTS['repeat_prompt'])
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt(PROMPT_TEXTS['goodbye_message'])
