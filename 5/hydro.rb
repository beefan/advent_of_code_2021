FILENAME = "input.txt"

Point = Struct.new(:x, :y)
Line = Struct.new(:points)

def parse_input(file_name)
  file = File.open(file_name)
  lines = file.readlines.map { |ln| ln.chomp }

  lines.map do |line|
    points = line.split(" -> ").map do |point|
      x, y = point.split(",")

      Point.new(x.to_i, y.to_i)
    end

    Line.new(points)
  end
end

def produce_diagram(lines)
  columns = lines.flat_map(&:points).map(&:x).max
  rows = lines.flat_map(&:points).map(&:y).max

  (0..rows).map do |y|
    (0..columns).map { |x| number_of_lines_covering_point(Point.new(x, y), lines) }
  end
end

def number_of_lines_covering_point(point, lines)
  lines.count { |line| line_covers_point?(point, line) }
end

def line_covers_point?(point, line)
  point1 = line.points[0]
  point2 = line.points[1]

  xs = [point1.x, point2.x].sort
  ys = [point1.y, point2.y].sort
  
  vertical = point1.x == point2.x
  return point.x == point1.x && point.y.between?(ys[0], ys[1]) if vertical

  horizontal = point1.y == point2.y
  return point.y == point1.y && point.x.between?(xs[0], xs[1]) if horizontal
end

def part1
  lines = parse_input(FILENAME)
  horizontal_and_vertical_lines = lines.select { |line| line.points.map(&:x).uniq.count == 1 || line.points.map(&:y).uniq.count == 1 }

  diagram = produce_diagram(horizontal_and_vertical_lines)
  diagram.flatten.count { |n| n >= 2 }
end

pp part1
