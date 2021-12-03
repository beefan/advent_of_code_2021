file = File.open("input.txt")
lines = file.readlines.map { |ln| ln.chomp }
n = lines.first.length - 1

gamma_rate = (0..n).map do |i|
  i_digits = lines.map { |ln| ln[i] }
  i_digits.count("1") > i_digits.count("0") ? "1" : "0"
end
epsilon_rate = gamma_rate.map { |d| d == "1" ? "0" : "1" }

puts gamma_rate.join.to_i(2) * epsilon_rate.join.to_i(2)