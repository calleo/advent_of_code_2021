def read_bits(filter)
  bits = File.open('03_input.txt').map{ |line| line.chomp }.select{ |line| line.start_with?(filter) }.map{ |line| line.split("").map(&:to_i) }
  bits
end

def rating(&block)
  filter = ''
  while true do
    bits = read_bits(filter)
    if bits.length == 1
      return bits[0]
    end
    bit_count = bits.transpose[filter.length]
    most_common = yield bit_count.tally
    filter << most_common.to_s
  end
end

oxygen = rating do |bit_count|
  bit_count[1].to_i >= bit_count[0].to_i ? 1 : 0
end

scrubber = rating do |bit_count|
  bit_count[0].to_i <= bit_count[1].to_i ? 0 : 1
end

puts(oxygen.join().to_i(2)*scrubber.join().to_i(2))