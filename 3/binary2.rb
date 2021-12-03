file = File.open("test_input.txt")
lines = file.readlines.map { |ln| ln.chomp }
n = lines.first.length - 1

oxygen_generator_rating = lines
co2_scrubber_rating = lines

i = 0
while oxygen_generator_rating.count > 1 do
  i_digits = oxygen_generator_rating.map { |ln| ln[i] }
  most_common_digit = i_digits.count("1") >= i_digits.count("0") ? "1" : "0"
  oxygen_generator_rating = oxygen_generator_rating.select { |ln| ln[i] == most_common_digit }
  i += 1
end

j = 0
while co2_scrubber_rating.count > 1 do
  j_digits = co2_scrubber_rating.map { |ln| ln[j] }
  least_common_digit = j_digits.count("0") <= j_digits.count("1") ? "0" : "1"
  co2_scrubber_rating = co2_scrubber_rating.select { |ln| ln[j] == least_common_digit }
  j += 1
end

puts oxygen_generator_rating.first.to_i(2) * co2_scrubber_rating.first.to_i(2)
