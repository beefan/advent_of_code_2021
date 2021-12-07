require 'ostruct'

FILENAME = "input.txt"

Point = Struct.new(:x, :y)
Line = Struct.new(:points)

def parse_input(file_name)
  file = File.open(file_name)
  lines = file.readlines.map { |ln| ln.chomp }

  max_x = 0
  max_y = 0
  lines = lines.map do |line|
    endpoints = line.split(" -> ").map do |point|
      x, y = point.split(",").map(&:to_i)
      max_x = x if max_x < x
      max_y = y if max_y < y

      Point.new(x, y)
    end
    points = points_between(endpoints)
    Line.new(points)
  end

  OpenStruct.new(
    :lines => lines,
    :max_x => max_x,
    :max_y => max_y
  )
end

def count_points(input)
  columns = input.max_x
  rows = input.max_y
  all_points = input.lines.flat_map(&:points).group_by { |point| point }.transform_values { |values| values.count }
  all_points.select { |_, count| count > 1 }.count
end

def points_between(endpoints)
  point1, point2 = endpoints
  x1, y1 = point1.to_h.values
  x2, y2 = point2.to_h.values

  ys = [y1, y2].sort
  xs = [x1, x2].sort

  vertical = point1.x == point2.x
  return (ys.first..ys.last).map { |y| Point.new(point1.x, y) } if vertical

  horizontal = point1.y == point2.y
  return (xs.first..xs.last).map { |x| Point.new(x, point1.y) } if horizontal

  slope = Rational((y2 - y1) / (x2 - x1))
  rise = slope.numerator
  run = slope.denominator

  iterator, end_point = [point1, point2].sort_by(&:x)
  points_between = [iterator]

  until iterator == end_point 
    iterator = Point.new(iterator.x + run, iterator.y + rise)
    points_between << iterator
  end

  points_between
end

def part2
  input = parse_input(FILENAME)
  count_points(input)
end

pp part2
