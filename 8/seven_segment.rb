Entry = Struct.new(:signal_patterns, :output_value)

def input
  file = File.open("input.txt")
  file.readlines.map { |ln| ln.chomp }.map do |line|
    values = line.split(" | ").map { |ln| ln.split(" ") }
    Entry.new(values[0], values[1])
  end
end

def functioning_display
  {
    0 => "abcefg",
    1 => "cf",
    2 => "acdeg",
    3 => "acdfg",
    4 => "bcdf",
    5 => "abdfg",
    6 => "abdefg",
    7 => "acf",
    8 => "abcdefg",
    9 => "abcdfg"
  }
end

def count_easy_digits_in_output(entry)
  unique_segments = [1, 4, 7, 8]
  unique_lengths = unique_segments.map { |d| functioning_display[d].length }

  entry.output_value.sum { |segment| unique_lengths.include?(segment.length) ? 1 : 0 }
end

def value(entry)
  broke_display = {}

  entry.signal_patterns.map { |pattern| pattern.chars.sort.join }.each do |pattern|
    easy_map = functioning_display.select { |k,v| [1, 4, 7, 8].include?(k) }.transform_values { |v| v.length }.invert
    digit = easy_map[pattern.length]

    broke_display[pattern] = digit
  end

  unsolved_patterns = broke_display.select { |_, v| v.nil? }.keys
  zero_six_nine = unsolved_patterns.sort_by(&:length).last(3)
  nine = zero_six_nine.detect { |pattern| broke_display.invert[4].chars.all? { |char| pattern.chars.include?(char) } }
  zero, six = (zero_six_nine - [nine]).partition { |pattern| broke_display.invert[1].chars.all? { |char| pattern.chars.include?(char) } }.map(&:first)

  broke_display[zero] = 0
  broke_display[six] = 6
  broke_display[nine] = 9

  unsolved_patterns = broke_display.select { |_, v| v.nil? }.keys
  three = unsolved_patterns.detect { |pattern| broke_display.invert[1].chars.all? { |char| pattern.chars.include?(char) } }
  five, two = (unsolved_patterns - [three]).partition { |pattern| (broke_display.invert[4].chars - broke_display.invert[1].chars).all? { |char| pattern.chars.include?(char) } }.map(&:first)

  broke_display[three] = 3
  broke_display[five] = 5
  broke_display[two] = 2

  entry.output_value.map { |pattern| pattern.chars.sort.join }.map { |digit| broke_display[digit].to_s }.join
end

def part1
  entries = input

  entries.reduce(0) do |sum, entry|
    sum + count_easy_digits_in_output(entry)
  end
end

def part2
  entries = input

  entries.reduce(0) do |sum, entry|
    sum + value(entry).to_i
  end
end

pp part2
# pp part1