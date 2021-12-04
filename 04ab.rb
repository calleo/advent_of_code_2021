def solve(board)
    moves = File.open('04_input.txt').first.chomp.split(',').map(&:to_i)
    moves.each_with_index do |move, count|
        board.each do |line|
            line = line.delete(move)
        end
        if board.any? { |line| line.length.zero? }
            return {last_move: move, moves: count, board: board}
        end
    end
    return nil
end

def boards
    boards = []
    board = []
    File.open('04a_input.txt').drop(2).each do |line|
        if line.chomp.length == 0
            boards << board + board.transpose
            board = []
        else
            board << line.split(' ').map(&:chomp).map(&:to_i)
        end
    end
    boards << board + board.transpose
    return boards
end

solutions = boards.map { |board| solve(board) }.compact
worst_solution = solutions.max { |a, b| a[:moves] <=> b[:moves] }
best_solution = solutions.min { |a, b| a[:moves] <=> b[:moves] }
puts("Best: #{best_solution[:board].flatten.uniq.inject(&:+)*best_solution[:last_move]}")
puts("Worst: #{worst_solution[:board].flatten.uniq.inject(&:+)*worst_solution[:last_move]}")
