# frozen_string_literal: true

ORIGINAL_STORY =
  "Yesterday, I found a (adjective) (noun) in my backyard.\nWithout thinking, I decided to (verb) it (adverb).\nI’ll never forget what happened next!"

def valid_text?(text)
  text.each_char.all? { |c| ('a'..'z').include?(c) }
end

def receive_user_text(prompt)
  print prompt

  loop do
    user_response = gets.chomp.downcase.strip

    return user_response if valid_text?(user_response)

    print '> '
  end
end

def user_madlibs
  puts "Hello! We're going to play a madlibs game!"
  puts 'Here is the sentence.'
  puts '----'
  puts "\"#{ORIGINAL_STORY}\""
  puts '----'

  placeholders = ['(adjective)', '(noun)', '(verb)', '(adverb)']
  new_story = ORIGINAL_STORY.dup

  placeholders.each do |word_space|
    article = word_space[2].start_with?('a') ? 'an' : 'a'
    stripped_word = word_space[1..-2]

    new_story.sub!(word_space, receive_user_text("Enter #{article} #{stripped_word}: "))
  end

  puts '----'
  puts 'Here is your finished story!'
  puts '----'
  puts "\"#{new_story}\""
end

user_madlibs
