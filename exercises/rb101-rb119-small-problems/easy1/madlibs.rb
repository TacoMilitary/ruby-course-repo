# frozen_string_literal: true

ORIGINAL_STORY =
  "Yesterday, I found a (adjective) (noun) in my backyard.\nWithout thinking, I decided to (verb) it (adverb).\nI’ll never forget what happened next!"

def receive_user_text(prompt)
  print prompt

  loop do
    response_valid = true
    user_response = gets.chomp.downcase.strip
    
    user_response.each_char do |c|
      response_valid = false unless ('a'..'z') === c
    end

    if response_valid
      return user_response
    else
      print '> '
    end
  end
end

def user_madlibs
  puts "Hello! We're going to play a madlibs game!"
  puts 'Here is the sentence.'
  puts '----'
  puts "\"#{ORIGINAL_STORY}\""
  puts '----'

  empty_blocks = ['(adjective)', '(noun)', '(verb)', '(adverb)']
  new_story = ORIGINAL_STORY.dup

  empty_blocks.each do |k|
    article = k[2] == 'd' ? 'an' : 'a'
    stripped_key = k[1..-2]

    new_story.sub!(k, receive_user_text("Enter #{article} #{stripped_key}: "))
  end

  puts '----'
  puts 'Here is your finished story!'
  puts '----'
  puts "\"#{new_story}\""
end

user_madlibs
