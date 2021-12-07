FILENAME = "input.txt"

def parse_input(file_name)
  file = File.open(file_name)
  file.readlines.map { |ln| ln.chomp.split(",") }.first.map(&:to_i)
end

def part1
  horizontal_positions = parse_input(FILENAME)
  counts_by_pos = horizontal_positions.group_by { |num| num }.transform_values { |values| values.count }

  winner = nil
  counts_by_pos.each_pair do |pos, count|
    fuel = counts_by_pos.sum { |pos1, count1| (pos - pos1).abs * count1 }
    
    if winner.nil? || fuel < winner
      winner = fuel
    end
  end

  winner
end

pp part1