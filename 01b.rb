# expected: 1543
puts(File.open('01_input.txt').map(&:to_i).each_cons(4).map { |all| all.slice(1, 4).sum > all.slice(0, 3).sum ? 1 : 0 }.sum)
