def print_in_box(user_text = '')
  formatted_user_text = '| ' + user_text + ' |'
  user_text_size = user_text.length

  formatted_empty_text = '| ' + (' ' * user_text_size) + ' |'
  formatted_box_edge = '+-' + ('-' * user_text_size) + '-+'

  final_text_box = "#{formatted_box_edge}\n#{formatted_empty_text}\n#{formatted_user_text}\n#{formatted_empty_text}\n#{formatted_box_edge}"
  puts final_text_box
end

print_in_box('To boldy go where no one has gone before.')
print_in_box('')
