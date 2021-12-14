@template = File.open('14_input.txt').first.chomp.split('')
@rules = File.open('14_input.txt').drop(2).map { |line| line.chomp.split('->').map { |e| e.strip } }.to_h

def count_population(pairs, rules, generations, counts)
  (0...generations).each do
    new_pairs = pairs.reduce(Hash.new(0)) do |pair_count, pair|
      element = rules[pair[0]]
      counts[element] ||= 0
      counts[element] += pair[1]
      pair_count.tap do |c|
        c[pair[0]] -= pair[1]
        c[(pair[0][0] + element)] += pair[1]
        c[(element + pair[0][1])] += pair[1]
      end
    end
    pairs.merge!(new_pairs.delete_if { |_k, v| v == 0 }) { |_key, a, b| a + b }
  end
  counts
end

pairs = @template.each_cons(2).map { |pair| [pair.join, 1] }
                 .reduce(Hash.new(0)) { |memo, pair| memo[pair[0]] += pair[1]; memo }
counts_10 = count_population(pairs, @rules, 10, @template.tally)
counts_40 = count_population(pairs, @rules, 40, @template.tally)

puts("(A) Result: #{counts_10}")
puts("(A) Answer: #{counts_10.values.max-counts_10.values.min} == 3406")
puts("(B) Result: #{counts_40}")
puts("(B) Answer: #{counts_40.values.max-counts_40.values.min} == 3941782230241")
