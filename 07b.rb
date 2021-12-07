crab_subs = File.open('07_input.txt').first.split(',').map(&:to_i)

def cost(subs, pos)
  subs.map{ |crab| (1 + (pos-crab).abs).fdiv(2)*(pos-crab).abs }.sum.to_i
end

lowest_cost = (crab_subs.min..crab_subs.max).min do |pos_a, pos_b|
  cost(crab_subs, pos_a) <=> cost(crab_subs, pos_b)
end

puts("#{cost(crab_subs, lowest_cost)}")