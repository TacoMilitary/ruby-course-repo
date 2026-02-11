def triangle(n = 1, face_left: true, upright: true)
  n = 1 if n <= 0

  triangles_array =
	Array.new(n) do |i|
		alignment_formula = upright ? (i + 1) : (n - i)
    '*' * alignment_formula
  end
  
	triangles_array.map! {|asterisks| asterisks.rjust(n)} if face_left

  puts triangles_array.join("\n")
end

triangle(5, upright: false)
triangle(3)
triangle(9, face_left: false, upright: false)