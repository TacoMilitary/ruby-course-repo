# frozen_string_literal: true
require 'yaml'

GAME_TXT = YAML.load_file('rps_remake_txt.yml')

CHOICE_WIN_RULES= {
  'rock' => 'scissors',
  'paper' => 'rock',
  'scissors' => 'paper'
}

POSSIBLE_CHOICES = CHOICE_WIN_RULES.keys

def prompt_user(prompt)
  puts prompt
  print '> '
  gets.chomp.strip
end

def clear_screen
  unless system('clear')
    puts "\n-----------"
  end
end

def divide_screen
  puts "\n-----------"
end

def display_error(message = 'Unknown error!')
  puts "[ERROR]: #{message}"
end

def user_rps_choice
  loop do
    user_input = prompt_user(GAME_TXT['before_shoot']).downcase

    if POSSIBLE_CHOICES.include?(user_input)
      return user_input
    else
      display_error(GAME_TXT['invalid_choice'])
      divide_screen
    end
  end
end

def win_against?(choice_1, choice_2)
  choice_1_wins_against = CHOICE_WIN_RULES[choice_1]
  
  choice_1_wins_against == choice_2 ? true : false
end

def cpu_rps_choice
  POSSIBLE_CHOICES.sample
end

def game_start
  clear_screen

  user_choice = user_rps_choice

  puts "\n#{GAME_TXT['after_shoot']}"

  computer_choice = cpu_rps_choice

  if win_against?(user_choice, computer_choice)
    puts 'WIN!'
  elsif win_against?(computer_choice, user_choice)
    puts 'LOSS!'
  else
    puts 'TIE!'
  end
end

game_start