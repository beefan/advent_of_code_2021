SCORE_SHEET = {
  :square => 57,
  :parens => 3,
  :squiggly => 1197,
  :pointy => 25137
}.freeze

AUTOCOMPLETE_SCORE = {
  :square => 2,
  :parens => 1,
  :squiggly => 3,
  :pointy => 4
}.freeze

Bracket = Struct.new(:type, :open?)

def input
  file = File.open("input.txt")
  file.readlines.map { |ln| ln.chomp.chars.map {|char| bracket(char) } }
end

def bracket(char)
  case char
  when "["
    Bracket.new(:square, true)
  when "]"
    Bracket.new(:square, false)
  when "("
    Bracket.new(:parens, true)
  when ")"
    Bracket.new(:parens, false)
  when "{"
    Bracket.new(:squiggly, true)
  when "}"
    Bracket.new(:squiggly, false)
  when "<"
    Bracket.new(:pointy, true)
  when ">"
    Bracket.new(:pointy, false)
  end
end

def first_illegal_char(line)
  chars = []

  line.each do |char|
    if char.open?
      chars << char
    else
      return char if chars.empty?
      if char.type == chars.last.type
        chars.pop
      else
        return char
      end
    end
  end

  nil
end

def completion_chars(line)
  chars = []

  line.each do |char|
    if char.open?
      chars << char
    elsif char.type == chars.last.type
      chars.pop
    end
  end

  chars.reverse
end

def part1
  lines = input
  corrupted_chars = lines.map { |line| first_illegal_char(line) }.compact
  corrupted_chars.sum { |char| SCORE_SHEET[char.type] }
end

def part2
  lines = input
  uncorrupted = lines.select { |line| first_illegal_char(line).nil? }
  completion_chars = uncorrupted.map { |line| completion_chars(line) }
  scores = completion_chars.map do |chars|
    chars.reduce(0) do |acc, char|
      acc * 5 + AUTOCOMPLETE_SCORE[char.type]
    end
  end

  scores.sort[scores.length/2]
end

pp part2