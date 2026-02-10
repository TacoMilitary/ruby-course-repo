def triangle(n = 1)
  n = 1 if n <= 0
  triangle_string = Array.new(n) {|i| ('*' * (i + 1)).rjust(n) }.join("\n")
  puts triangle_string
end

triangle(5)
triangle(9)