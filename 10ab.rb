TOKENS = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>',
}

POINTS = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137,
}

AUTO_COMPLETE_POINTS = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4,
}

def start?(token)
  !TOKENS.keys.index(token).nil?
end

def end?(token)
  !start?(token)
end

def find_invalid_char(line)
  line.reduce([]) do |tokens, token|
    if start?(token)
      tokens.push(token)
    else
      if TOKENS[tokens.last] == token
        tokens.pop
      else
        return token
      end
    end
    tokens
  end
  nil
end

def find_autocomplete_chars(line)
  missing = line.reduce([]) do |tokens, token|
    if start?(token)
      tokens.push(token)
    else
      if TOKENS[tokens.last] == token
        tokens.pop
      end
    end
    tokens
  end
  missing.reverse.map { |t| TOKENS[t] }
end

input = File.open('10_input.txt').map { |line| line.chomp.split('') }
invalid_char_score = input.map { |line| find_invalid_char(line) }.compact.map { |c| POINTS[c] }.sum
puts("Invalid characters score: #{invalid_char_score} == 167379")

valid_lines = input.select { |i| find_invalid_char(i).nil? }
ac_scores = valid_lines.map { |l| find_autocomplete_chars(l) }.map do |line|
  line.reduce(0) { |score, t| (score * 5) + AUTO_COMPLETE_POINTS[t] }
end

puts("Autocomplete score: #{ac_scores.sort[ac_scores.length.fdiv(2).ceil-1]} == 2776842859")
