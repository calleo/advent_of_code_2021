input = File.open('08_input.txt').map{ |line| line.split('|') }
            .map{ |parts| {samples: parts[0].split(' '), decode: parts[1].split(' ')} }
count = input.flat_map{ |inp| inp[:decode].filter{ |code| [2,4,3,7].include?(code.length) } }.length
puts("#{count} == 352")