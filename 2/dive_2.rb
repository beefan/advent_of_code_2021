require 'ostruct'

file = File.open("input.txt")
lines = file.readlines.map { |ln| ln.chomp.split(" ") }
instructions = lines.map { |ln| OpenStruct.new(:direction => ln[0], :value => ln[1].to_i) }

horiz = 0
depth = 0
aim = 0

instructions.each do |instruction|
  x = instruction.value

  case instruction.direction
  when "forward"
    horiz += x
    depth += (aim * x)
  when "down"
    aim += x
  when "up"
    aim -= x
  end
end


puts horiz * depth