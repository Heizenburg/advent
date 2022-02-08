class Submarine
  attr_reader :depth, :position, :aim

  def initialize(&block)
    @depth = 0
    @position = 0
    @aim = 0

    if block_given? 
      instance_eval(&block)
    end
  end

  def forward(n) 
    @position += n 
    @depth += n * aim
  end 

  def down(n)
    @aim += n
  end 

  def up(n)
    @aim -= n
  end

  def point
    depth * position
  end   
end

if __FILE__ == $0
  instructions = File.read(ARGV.first)

  submarine = Submarine.new do 
    eval(instructions)
  end
  
  puts submarine.point
end 