Point = Struct.new(:height, :x, :y)

@height_map = File.open('09_input.txt').map.with_index do |line, y|
  line.chomp.split('').map(&:to_i).map.with_index { |height, x| Point.new(height, x, y) }
end

def point_at(x, y)
  return nil if x < 0 || y < 0 || y > @height_map.length-1 || x > @height_map[y].length-1
  @height_map[y][x]
end

def upwards?(a, b)
  return false if b.nil? || b.height == 9
  a.height < b.height
end

def append_if_upwards(a, b, basin)
  if upwards?(a, b) && basin.index(b).nil?
    basin.append(b)
  end
end

def low_points
  @height_map.flatten.select do |point|
    neighbors = [
      point_at(point.x, point.y-1),
      point_at(point.x, point.y+1),
      point_at(point.x-1, point.y),
      point_at(point.x+1, point.y)
    ].compact
    neighbors.all? { |n| n.height > point.height }
  end
end

def basins(low_points)
  low_points.map do |point|
    basin = [point]
    while true do
      _basin = basin.dup
      _basin.each do |p|
        append_if_upwards(p, point_at(p.x, p.y-1), basin)
        append_if_upwards(p, point_at(p.x, p.y+1), basin)
        append_if_upwards(p, point_at(p.x-1, p.y), basin)
        append_if_upwards(p, point_at(p.x+1, p.y), basin)
      end
      break if _basin.length == basin.length
    end
    basin
  end
end


puts("risk level: #{low_points.map{ |r| r.height + 1 }.sum}")
puts("basins: #{basins(low_points).map{ |b| b.length }.sort.reverse.take(3).reduce(&:*)}")