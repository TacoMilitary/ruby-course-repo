# frozen_string_literal: true
MAX_TEXT_WIDTH = 76

def format_multiline_text(original_text = '')
  last_wrapped_index = 0
  original_length = original_text.length
  final_char_index = original_length - 1
  text_array = []
  until last_wrapped_index >= final_char_index
    wrap_to_index = [last_wrapped_index + (MAX_TEXT_WIDTH - 1), final_char_index].min

    wrapped_unformatted_text = original_text[last_wrapped_index..wrap_to_index]

    remaining_whitespace = [MAX_TEXT_WIDTH, original_length].min - wrapped_unformatted_text.length

    formatted_line = "| #{wrapped_unformatted_text}#{' ' * remaining_whitespace} |"

    text_array.push(formatted_line)

    last_wrapped_index = wrap_to_index + 1
  end

  text_array.join("\n")
end

def print_in_box(user_text)
  formatted_user_text = (user_text == '' || user_text.nil?) ? '|  |' : format_multiline_text(user_text) # "| #{user_text} |"

  text_max_length = user_text.length.clamp(0, MAX_TEXT_WIDTH)

  formatted_empty_text = "| #{' ' * text_max_length} |"
  formatted_box_edge = "+-#{'-' * text_max_length}-+"

  final_text_box = "#{formatted_box_edge}\n#{formatted_empty_text}\n#{formatted_user_text}\n#{formatted_empty_text}\n#{formatted_box_edge}"
  puts final_text_box
end

print_in_box('To boldy go where no one has gone before.')
print_in_box('Bright ideas travel far when curiosity, patience, and courage.')
print_in_box('Bright ideas travel far when curiosity, patience, and courage walk together now.')
print_in_box('Bright ideas travel far when curiosity, patience, and courage walk together now. Chocolate cupcakes and strawberry pies.')
print_in_box('')
