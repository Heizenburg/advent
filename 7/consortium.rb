class Consortium
  attr_reader :positions

  def initialize(positions)
    @positions = positions  
  end

  def min_position
    positions.min
  end

  def max_position
    positions.max
  end

  def fuel(n)
    positions.inject(0) do |fuel, pos|
      x = (pos - n).abs
      fuel + ((x * (x + 1)) / 2.0).ceil
    end
  end

    
  def min_fuel
    min_fuel = Float::INFINITY
    min_position.upto(max_position).each do |n|
      f = fuel(n)
      min_fuel = f if f < min_fuel
    end
    min_fuel
  end
end

if __FILE__ == $0 
  input = File.read(ARGV.first).chomp.split(",").map(&:to_i)
  consortium = Consortium.new(input)
  puts consortium.min_fuel
end 