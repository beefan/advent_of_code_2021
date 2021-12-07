ReproductionCohort = Struct.new(:days_til_reproduction, :count)

def starting_pop
  file = File.open("input.txt")
  input_array = file.readlines.map { |ln| ln.chomp.split(",").map(&:to_i) }.first

  cohorts = (0..8).map { |days| ReproductionCohort.new(days, 0) }
  input_array.each do |days|
    cohorts.detect { |cohort| cohort.days_til_reproduction == days }.count += 1
  end

  cohorts
end

def simulate_fish(starting_pop, days)
  pop = starting_pop

  (1..days).each do
    pop = grow(pop)
  end

  pop
end

def grow(pop)
  births = pop.detect { |c| reproduction_age?(c) }.count

  pop = pop.reject { |cohort| cohort.days_til_reproduction == 0 }
  pop.each { |cohort| cohort.days_til_reproduction -= 1 }

  pop << ReproductionCohort.new(8, births)
  pop.detect { |c| c.days_til_reproduction == 6 }.count += births

  pop
end

def reproduction_age?(cohort)
  cohort.days_til_reproduction == 0
end

def part2
  starting_pop
  population = simulate_fish(starting_pop, 256)
  population.sum(&:count)
end

pp part2