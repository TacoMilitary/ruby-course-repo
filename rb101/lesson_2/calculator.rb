# frozen_string_literal: true

# answer = Kernel.gets()
# Kernel.puts(answer)

Kernel.puts('Welcome to the Calculator!')

Kernel.puts("What's the first number?")
number1 = Kernel.gets.chomp

Kernel.puts('What is the second number?')
number2 = Kernel.gets.chomp

Kernel.puts('What operation would you like to perform? 1) add 2) subtract 3) multiply 4) divide')
operator = Kernel.gets.chomp

result = case operator
         when '1'
           number1.to_i + number2.to_i
         when '2'
           number1.to_i - number2.to_i
         when '3'
           number1.to_i * number2.to_i
         else
           number1.to_f / number2
         end

Kernel.puts("The result is #{result}")
