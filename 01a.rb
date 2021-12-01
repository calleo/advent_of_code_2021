# expected: 1521
puts(File.open('01_input.txt').map(&:to_i).each_cons(2).map { |prev, curr| curr > prev ? 1 : 0 }.sum)
