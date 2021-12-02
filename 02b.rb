Move = Struct.new(:direction, :steps)
Position = Struct.new(:horizontal, :depth, :aim)

moves = File.open('02_input.txt')
            .map{ |line| line.split(" ") }
            .map{ |parts| Move.new(parts[0], parts[1].to_i) }

position = moves.reduce(Position.new(0, 0, 0)) do |pos, move|
  case move.direction
  when 'up'
    pos.aim -= move.steps
  when 'down'
    pos.aim += move.steps
  when 'forward'
    pos.horizontal += move.steps
    pos.depth += pos.aim * move.steps
  else
    raise "unknown direction #{move.direction}"
  end
  pos
end

puts(position.horizontal * position.depth)