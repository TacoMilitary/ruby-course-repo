# frozen_string_literal: true

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

def game_start
  puts ''
end

game_start