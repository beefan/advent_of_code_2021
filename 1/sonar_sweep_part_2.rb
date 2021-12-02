file = File.open("sonar_sweep_test_input.txt")
lines = file.readlines.map { |ln| ln.chomp.to_i }

sums = []
lines.each.with_index do |_, i|
  sums << (i..i+2).sum { |v| lines.fetch(v, 0) }
end

last_value = nil
count = sums.inject(0) do |acc, value|
  if !!last_value && value > last_value
    acc += 1
  end

  last_value = value

  acc
end

puts count