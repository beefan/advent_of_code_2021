FILENAME = "input.txt"

def parse_input(file_name)
  file = File.open(file_name)
  file.readlines.map { |ln| ln.chomp.split(",") }.first.map(&:to_i)
end

def part2
  horizontal_positions = parse_input(FILENAME).sort
  counts_by_pos = (horizontal_positions.min..horizontal_positions.max).map { |pos| [pos, 0] }.to_h
  horizontal_positions.group_by { |pos| pos }.transform_values { |values| values.count }.each_pair do |pos, count|
    counts_by_pos[pos] += count
  end
  
  winner = nil
  counts_by_pos.each_pair do |pos, count|
    fuel = counts_by_pos.sum do |pos1, count1|
      steps = (pos - pos1).abs
      (1..steps).sum * count1
    end
    
    if winner.nil? || fuel < winner
      winner = fuel
    end
  end

  winner
end

pp part2