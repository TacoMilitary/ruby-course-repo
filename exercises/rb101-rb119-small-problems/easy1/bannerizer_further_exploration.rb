# frozen_string_literal: true
MAX_TEXT_WIDTH = 76

def format_multiline_text(original_text = '', truncate = false)
  original_length = original_text.length
  
  if truncate
    final_line_text = "| #{original_text} |"
    max_text_length = MAX_TEXT_WIDTH - 4 
    if original_length >= max_text_length # 3 for the periods + 1 for array index
      final_line_text = "| #{original_text[0..max_text_length]}... |" 
    end
    return final_line_text 
  end

  last_wrapped_index = 0
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

def print_in_box(user_text, truncate = false)
  formatted_user_text = (user_text == '' || user_text.nil?) ? '|  |' : format_multiline_text(user_text, truncate) # "| #{user_text} |"

  text_max_length = user_text.length.clamp(0, MAX_TEXT_WIDTH)

  formatted_empty_text = "| #{' ' * text_max_length} |"
  formatted_box_edge = "+-#{'-' * text_max_length}-+"

  final_text_box = "#{formatted_box_edge}\n#{formatted_empty_text}\n#{formatted_user_text}\n#{formatted_empty_text}\n#{formatted_box_edge}"
  puts final_text_box
end

print_in_box('To boldy go where no one has gone before.', true)
print_in_box('Bright ideas travel far when curiosity, patience, and courage.')
print_in_box('Bright ideas travel far when curiosity, patience, and courage walk together now.', false)
print_in_box('Bright ideas travel far when curiosity, patience, and courage walk together now. Chocolate cupcakes and strawberry pies.', true)
print_in_box('')
