def repeat(repeated_string="", repeat_times=1)
    repeat_times = 1 if repeat_times <= 0
    repeat_times.times {puts repeated_string}
    # another way of doing it
    #(puts repeated_string + "\n#{repeated_string}" * (repeat_times - 1)) if repeat_times > 0
end

repeat('Hello', 3)