points = File.open('05_input.txt')
             .map { |line| line.split('->') }
             .map{ |points| [points[0].split(',').map(&:chomp).map(&:to_i), points[1].split(',').map(&:chomp).map(&:to_i)].sort { |a, b| a.sum <=> b.sum } }

grid = points.reduce(Hash.new) do |memo, point|
  (point[0][0]..point[1][0]).each do |x|
    (point[0][1]..point[1][1]).each do |y|
      memo[x] ||= Hash.new(0)
      memo[x][y] += 1
    end
  end
  memo
end

puts("#{grid.values.flat_map(&:values).count{ |v| v > 1 }}")