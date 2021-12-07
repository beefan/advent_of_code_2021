Fish = Struct.new(:days_til_reproduction)

def starting_fish
  file = File.open("test_input.txt")
  file.readlines.map { |ln| ln.chomp.split(",") }.first.map do |days|
    Fish.new(days.to_i)
  end
end

def simulate_fish(starting_fish, days)
  fishes = starting_fish.dup

  (1..days).each do
    fishes = fishes.flat_map do |fish|
      grow(fish)
    end
  end

  fishes
end

def grow(fish)
  if reproduction_age?(fish)
    [Fish.new(6), give_birth]
  else
    Fish.new(fish.days_til_reproduction - 1)
  end
end

def reproduction_age?(fish)
  fish.days_til_reproduction == 0
end

def give_birth
  Fish.new(8)
end

def part1
  population = simulate_fish(starting_fish, 80)
  population.count
end

puts part1