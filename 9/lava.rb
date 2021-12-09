Point = Struct.new(:value, :x, :y)

def input
  file = File.open("input.txt")
  file.readlines.map { |ln| ln.chomp }.map do |line|
    line.chars.map(&:to_i)
  end
end

def low_points(height_map)
  low = []
  height_map.each.with_index do |row, y|
    row.each.with_index do |point, x|
      pt = Point.new(point, x, y)
      if lowest_point_around?(pt, height_map)
        low << pt
      end
    end
  end

  low
end

def adjacent_points(point, height_map)
  row_length = height_map[0].count
  column_length = height_map.count
  x = point.x
  y = point.y

  adjacent_points = [
    [x + 1, y],
    [x - 1, y],
    [x, y + 1],
    [x, y - 1]
  ].reject do |point|
    point.any?(&:negative?) || point[0] >= row_length || point[1] >= column_length
  end

  adjacent_points.map do |x, y|
    value = height_map[y][x]
    Point.new(value, x, y)
  end
end

def lowest_point_around?(point, height_map)
  adjacent_points(point, height_map).all? { |adj| point.value < adj.value }
end

def basin(point, height_map)
  basin = [point]

  while true do
    adj = basin.flat_map do |pt|
      adjacent_points(pt, height_map).reject { |pnt| pnt.value == 9 || basin.include?(pnt) }
    end
    break if adj.empty?

    basin += adj
  end

  basin.uniq
end

def part1
  height_map = input
  low_points = low_points(height_map)
  low_points.sum { |point| point.value + 1 }
end

def part2
  height_map = input
  low_points = low_points(height_map)
  basins = low_points.map { |point| basin(point, height_map) }

  basins.map(&:count).sort.last(3).reduce(1) { |product, count| product * count }
end

puts part2.to_s