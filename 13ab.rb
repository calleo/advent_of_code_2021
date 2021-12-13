DOT = '#'
EMPTY = '.'
HORIZONTAL = 'y'
VERTICAL = 'x'

def board
  dots = File.open('13_input.txt').filter { |line| !line.start_with?('fold') && line.chomp.length > 0 }.map { |line| line.chomp.split(',').map(&:to_i)  }
  size = dots.reduce([0,0]) { |size, dot| [[size[0], dot[0]+1].max, [size[1], dot[1]+1].max] }
  board = (0...size[1]).map { Array.new(size[0],EMPTY) }
  dots.reduce(board) do |board, dot|
    board.tap { |b| b[dot[1]][dot[0]] = DOT }
  end
end

def instructions
  File.open('13_input.txt').filter { |line| line.start_with?('fold') }
      .map { |line| line.split('=') }.map { |i| [i[0][-1], i[1].to_i] }
end

def split_vertical(board, position)
  [board.map { |row| row[0...position] }, board.map { |row| row[position+1...] }]
end

def split_horizontal(board, position)
  [board[0...position], board[position+1...]]
end

def merge(a, b)
  a.map.with_index do |row, y|
    row.map.with_index { |elem, x| elem == EMPTY ? b[y][x] : elem }
  end
end

def fold_at(board, position, orientation)
  sides = case orientation
          when HORIZONTAL
            sides = split_horizontal(board, position)
            [sides[0], sides[1].reverse]
          when VERTICAL
            sides = split_vertical(board, position)
            [sides[0], sides[1].map { |row| row.reverse }]
          else
            raise "Unknown orientation: #{orientation}"
          end
  merge(sides[0], sides[1])
end

def print_board(board)
  board.each do |row|
    puts("#{row.map { |v| (v || EMPTY) }.join('|')}")
  end
end

def fold(board, instructions)
  instructions.each do |instr|
    board = fold_at(board, instr[1], instr[0])
  end
  board
end

puts("(A) Filled dots: #{fold(board, [instructions.first]).flatten.select { |dot| dot == DOT }.length}")
puts('(B)')
print_board(fold(board, instructions))