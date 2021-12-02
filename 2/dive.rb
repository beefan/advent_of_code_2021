require 'ostruct'

file = File.open("input.txt")
lines = file.readlines.map { |ln| ln.chomp.split(" ") }
instructions = lines.map { |ln| OpenStruct.new(:direction => ln[0], :value => ln[1].to_i) }

horiz = 0
depth = 0

instructions.each do |instruction|
  case instruction.direction
  when "forward"
    horiz += instruction.value
  when "down"
    depth += instruction.value
  when "up"
    depth -= instruction.value
  end
end


puts horiz * depth