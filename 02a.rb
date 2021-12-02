Move = Struct.new(:direction, :steps)
Position = Struct.new(:x, :y)

moves = File.open('02_input.txt')
            .map{ |line| line.split(" ") }
            .map{ |parts| Move.new(parts[0], parts[1].to_i) }

position = moves.reduce(Position.new(0, 0)) do |pos, move|
  case move.direction
  when 'up'
    pos.y -= move.steps
  when 'down'
    pos.y += move.steps
  when 'forward'
    pos.x += move.steps
  else
    raise "unknown direction #{move.direction}"
  end
  pos
end

puts(position.x * position.y)