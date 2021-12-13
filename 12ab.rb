Edge = Struct.new(:from, :to)
Path = Struct.new(:discovered, :finished)
START = "start"
GOAL = "end"
START_END = [GOAL, START]

def big_cave?(cave)
  cave == cave.upcase
end

def adjacent(edge, edges)
  edges.select { |e| e.from == edge.to }
end

def unfinished_paths?(paths)
  paths.any? { |p| p.finished == false }
end

def find_paths(edges, limit)
  paths = edges.select { |e| e.from == START }.map { |e| Path.new([e], false) }
  while unfinished_paths?(paths) do
    new_paths = paths.flat_map do |path|
      unless path.finished
        new_edges = adjacent(path.discovered.last, edges).select do |e|
          visited_small = path.discovered.select { |c| !big_cave?(c.to) }.map { |p| p.to }
          visited_small.index(e.to).nil? || visited_small.tally.values.max < limit ? true : false
        end
        if new_edges.empty?
          path.finished = true and nil
        else
          new_edges.map { |e| Path.new(path.discovered + [e], START_END.include?(e.to) ) }
        end
      end
    end
    paths = paths.select { |p| p.finished }.concat(new_paths.compact)
  end
  paths.select { |p| p.discovered.last.to == GOAL }
end

edges = File.open('12_input.txt').map { |line| line.chomp.split('-') }.flat_map { |e| [Edge.new(e[0], e[1]), Edge.new(e[1], e[0])] }
puts("Found: #{find_paths(edges, 1).length} == 5212")
puts("Found: #{find_paths(edges, 2).length} == 134862")