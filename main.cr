require "./src/ShakespeareMonkey"

def usage
  "Usage : ./monkey target [population] [mutation rate]"
end

if ARGV.empty? || ARGV.size > 3
  puts usage
elsif ARGV.size == 1
  if ARGV[0] == "-h" || ARGV[0] == "--help"
    puts usage
  else
    GeneticAlgorithm::ShakespeareMonkey.new(ARGV[0]).launch_generation
  end
elsif ARGV.size == 2
  if ARGV[1].to_i <= 0
    puts usage
    puts "Population must be a positive number different than zero."
  else
    GeneticAlgorithm::ShakespeareMonkey.new(ARGV[0], ARGV[1].to_i).launch_generation
  end
else
  if ARGV[1].to_i <= 0 || ARGV[2].to_f <= 0
    puts usage
    puts "Population and mutation rate must be a positive number different than zero."
  else
    GeneticAlgorithm::ShakespeareMonkey.new(ARGV[0], ARGV[1].to_i, ARGV[2].to_f).launch_generation
  end
end
