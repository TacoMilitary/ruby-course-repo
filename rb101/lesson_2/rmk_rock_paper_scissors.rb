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

def player_rps_get
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

def cpu_rps_get
  POSSIBLE_CHOICES.sample
end

def match_outcome_get(player_1_rps, player_2_rps)
  if win_against?(player_1_rps, player_2_rps)
    'win'
  elsif win_against?(player_2_rps, player_1_rps)
    'lose'
  else
    'draw'
  end
end

def display_results(outcome)
  case outcome
  when 'win' then puts GAME_TXT['win_message']
  when 'lose' then puts GAME_TXT['lose_message']
  else puts GAME_TXT['draw_message']
  end
end

def ask_for_rematch?
  loop do
    user_input = prompt_user(GAME_TXT['rematch_ask']).downcase

    case user_input
    when 'y'
      return true
    when 'n'
      return false
    else
      display_error(GAME_TXT['invalid_choice'])
      divide_screen
    end
  end
end

def game_start
  continue_game = true

  clear_screen
  while continue_game
    player_choice = player_rps_get

    puts "\n#{GAME_TXT['after_shoot']}"
    
    computer_choice = cpu_rps_get

    player_outcome = match_outcome_get(player_choice, computer_choice)

    display_results

    unless player_outcome == 'tie'
      continue_game = ask_for_rematch?
    end
  end
end

game_start