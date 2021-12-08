require 'set'

inputs = File.open('08_input.txt').map{ |line| line.split('|') }
            .map{ |parts| {samples: parts[0].split(' '), decode: parts[1].split(' ')} }

all_results = inputs.map do |input|
  encodings = []
  while encodings.compact.length != 10 do
    samples = input[:samples].map{ |s| s.split('').to_set } - encodings
    samples.each do |number|
      case number.length
      when 2
        encodings[1] = number
      when 3
        encodings[7] = number
      when 4
        encodings[4] = number
      when 5
        if encodings[7]&.subset?(number)
          encodings[3] = number
        elsif encodings[3] && encodings[6] && number.subset?(encodings[6])
          encodings[5] = number
        elsif encodings[3] && encodings[5]
          encodings[2] = number
        end
      when 6
        if encodings[7]&.subset?(number) && encodings[3]&.subset?(number)
          encodings[9] = number
        elsif encodings[9] && encodings[7]&.subset?(number)
          encodings[0] = number
        elsif encodings[9] && encodings[0]
          encodings[6] = number
        end
      when 7
        encodings[8] = number
      else
        raise "Unrecognized length: #{number.length} for #{number}"
      end
    end
  end
  input[:decode].map{ |number| encodings.index(number.split('').to_set) }.join().to_i
end

puts("#{all_results.sum} == 936117")
