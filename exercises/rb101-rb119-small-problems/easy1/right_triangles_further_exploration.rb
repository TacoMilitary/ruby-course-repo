def triangle(n = 1, face_left: true, upright: true)
  n = 1 if n <= 0

  
  triangles_array =
  if face_left
    Array.new(n) do |i|
      if upright
        ('*' * (i + 1)).rjust(n)
      else
        ('*' * (n - i)).rjust(n)
      end
    end
  else
    Array.new(n) do |i| 
      if upright
        ('*' * (i + 1)).ljust(n)
      else
        ('*' * (n - i)).ljust(n)
      end
    end
  end

  puts triangles_array.join("\n")
end

triangle(5, upright: false)
triangle(9, face_left: false, upright: false)