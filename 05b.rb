lines = File.open('05_input.txt')
             .map { |line| line.split('->') }
             .map{ |points| [points[0].split(',').map(&:chomp).map(&:to_i), points[1].split(',').map(&:chomp).map(&:to_i)] }

grid = lines.reduce(Hash.new) do |grid, line|
  while line[0] != line[1] do
    grid[line[0][0]] ||= Hash.new(0)
    grid[line[0][0]][line[0][1]] += 1

    if line[0][0] < line[1][0]
      line[0][0] += 1
    elsif line[0][0] > line[1][0]
      line[0][0] -= 1
    end

    if line[0][1] < line[1][1]
      line[0][1] += 1
    elsif line[0][1] > line[1][1]
      line[0][1] -= 1
    end
  end
  grid[line[0][0]] ||= Hash.new(0)
  grid[line[0][0]][line[0][1]] += 1
  grid
end

puts("#{grid.values.flat_map(&:values).count{ |v| v > 1 }}")