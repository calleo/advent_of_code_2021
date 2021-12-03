bits = File.open('03_input.txt').map{ |line| line.chomp.split("").map(&:to_i) }.transpose.map(&:tally)
gamma = bits.map{ |b| b[0] > b[1] ? 0 : 1 }.join().to_i(2)
epsilon = bits.map{ |b| b[0] < b[1] ? 0 : 1 }.join().to_i(2)
puts(gamma*epsilon)