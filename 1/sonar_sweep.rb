file = File.open("sonar_sweep_input.txt")
lines = file.readlines.map { |ln| ln.chomp.to_i }
last_value = nil
count = lines.inject(0) do |acc, value|
  if !!last_value && value > last_value
    acc += 1
  end

  last_value = value

  acc
end

puts count