def simulate(days)
  input = File.open('06_input.txt').first.split(',').map(&:to_i)
  lanternfish = (0..8).map{ |age| input.count{ |i| i == age } }
  (0...days).each do
    reborn = newborn = lanternfish.shift
    lanternfish[6] = lanternfish[6] + reborn
    lanternfish[8] = newborn
  end
  lanternfish.sum
end

puts("#{simulate(80)} == 350917")
puts("#{simulate(256)} == 1592918715629")
