Octopus = Struct.new(:energy, :x, :y)

def any_flashable?(octopus_map, flashed)
  octopus_map.any? do |row|
    row.any? { |octopus| octopus.energy >= 10 && flashed.index(octopus).nil? }
  end
end

def increase_all!(octopus_map)
  octopus_map.each do |row|
    row.each { |octopus| octopus.energy += 1 }
  end
end

def octopus_at(x, y, octopus_map)
  return nil if x < 0 || y < 0 || y > octopus_map.length-1 || x > octopus_map[y].length-1
  octopus_map[y][x]
end

def flash!(octopus, octopus_map)
  neighbors = [
    octopus_at(octopus.x, octopus.y-1, octopus_map),
    octopus_at(octopus.x, octopus.y+1, octopus_map),
    octopus_at(octopus.x-1, octopus.y, octopus_map),
    octopus_at(octopus.x+1, octopus.y, octopus_map),
    octopus_at(octopus.x-1, octopus.y-1, octopus_map),
    octopus_at(octopus.x+1, octopus.y-1, octopus_map),
    octopus_at(octopus.x-1, octopus.y+1, octopus_map),
    octopus_at(octopus.x+1, octopus.y+1, octopus_map),
  ].compact
  neighbors.each do |o|
    o.energy += 1
  end
  octopus
end

def main(steps)
  octopus_map = File.open('11_input.txt').map.with_index do |line, y|
    line.chomp.split('').map(&:to_i).map.with_index { |energy, x| Octopus.new(energy, x, y) }
  end
  flashes = 0
  synchronized_flash_at = 0

  (0...steps).each do |step|
    increase_all!(octopus_map)
    flashed = []
    while any_flashable?(octopus_map, flashed)
      octopus_map.each do |row|
        row.each do |octopus|
          if octopus.energy >= 10 && flashed.index(octopus).nil?
            flash!(octopus, octopus_map)
            flashed << octopus
            flashes += 1
          end
        end
      end
    end

    synchronized_flash_at = step + 1 if flashed.length == octopus_map.flatten.length && synchronized_flash_at == 0
    flashed.each { |o| o.energy = 0 }
  end

  puts("Flashes: #{flashes} == 1683 (100 steps)")
  puts("Synchronized at: #{synchronized_flash_at} == 788")
end

main(100)
main(1000)
