module DNA
  class DNA
    property dna : Array(Char)
    property size : Int32

    def initialize(nbr : Int)
      @size = nbr
      @dna = Array(Char).new(nbr, '0')
      i : Int32 = 0
      r = Random.new
      while i < nbr
  	    @dna[i] = r.rand(32..128).unsafe_chr
        i += 1
    	end
    end

    def getDna : String
      @dna.join
    end

    def calculateFitness(target : String) : Float64
      score : Int32 = 0
      i : Int32 = 0
      target.size.times do
         if @dna[i] == target[i]
           score += 1
         end
         i += 1
      end
      Math.exp(score.to_f / target.size.to_f)
    end

    def reproduce(partner : DNA) : DNA
      child = DNA.new(@size)
      i : Int32 = 0
      until_i : Int32 = Random.new.rand(@size)

      @size.times do
        if i < until_i
          child.dna[i] = @dna[i]
        else
          child.dna[i] = partner.dna[i]
        end
        i += 1
      end
      child
    end

    def mutate(float mutationRate) : Bool
      i : Int32 = 0
      r = Random.new
      res : Bool = false

      @size.times do
        if r.rand(1.0) < mutationRate
          @dna[i] = r.rand(32..128).unsafe_chr
          res = true
        end
        i += 1
      end
      res
    end
  end
end
