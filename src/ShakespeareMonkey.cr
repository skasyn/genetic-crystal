require "./DNA"
module GeneticAlgorithm
  class ShakespeareMonkey
    include DNA

    property target : String
    property pop_size : Int32
    property mR : Float64
    property population : Array(DNA)
    property mating_pool_size : Int32
    property mating_pool : Array(DNA)

    def initialize(@target : String, @pop_size : Int32 = 150, @mR : Float64 = 0.01)
      @population = Array(DNA).new(@pop_size)
      size : Int32 = @target.size

      @pop_size.times do
        @population.push(DNA.new(size))
      end
      @mating_pool_size = 0
      @mating_pool = Array(DNA).new
    end

    def create_mating_pool
      i : Int32 = 0
      pop_fitness : Array(Int32) = Array(Int32).new(@pop_size, 0)
      biggest : Int32 = 0

      @pop_size.times do
        pop_fitness[i] = (@population[i].calculateFitness(@target) * 100.0).to_i
        if pop_fitness[i] > pop_fitness[biggest]
          biggest = i
        end
        @mating_pool_size += pop_fitness[i]
        i += 1
      end
      puts "Best fit : #{@population[biggest].getDna}"
      puts "Fitness : #{pop_fitness[biggest]}\n"
      @mating_pool = Array(DNA).new(@mating_pool_size)
      i = 0
      @pop_size.times do
        pop_fitness[i].times do
          @mating_pool.push(@population[i])
        end
        i += 1
      end
    end

    def repopulate
      i : Int32 = 0
      r = Random.new
      @pop_size.times do
        parent_a : DNA = mating_pool[r.rand(@mating_pool_size)]
        parent_b : DNA = mating_pool[r.rand(@mating_pool_size)]
        child : DNA = parent_a.reproduce(parent_b)
        child.mutate(@mR)
        population[i] = child
        i += 1
      end
    end

    def phrase_found : Bool
      i : Int32 = 0
      @pop_size.times do
        if @population[i].getDna == @target
          puts @population[i].getDna
          return true
        end
        i += 1
      end
      false
    end

    def empty_mating_pool
      @mating_pool = [] of DNA
      @mating_pool_size = 0
    end

    def launch_generation
      generation : Int32 = 0

      while !phrase_found
        puts "Generation : #{generation}"
        create_mating_pool
        repopulate
        generation += 1
        empty_mating_pool
      end
    end
  end
end
