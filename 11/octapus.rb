require 'byebug'

class Octapus
  attr_reader :energy, :flashes
  
  def initialize(energy)
    @energy = energy
    @flashes = 0
  end

  def pass_days(n)
    n.times { tick }
  end

  def first_full_flash
    1500.times do |i|
      tick
      return i + 1 if full_flash?
    end 
  end

  def full_flash?
    @energy.all? { |r| r.all? { |e| e == 0}}
  end

  def tick
    @flashed = []
    @energy.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        @energy[i][j] += 1
      end
    end

    @energy.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if @energy[i][j] > 9
          flash([i, j])
        end
      end
    end

    @energy.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if @energy[i][j] > 9
          @energy[i][j] = 0
        end
      end
    end
    @flashes += @energy.flatten.count(0)
  end

  def to_s
    @energy.map do |row|
      row.map {|c| c}.join
    end
  end

  def flash((i, j))
    return if @flashed.include?([i, j])
    @flashed << [i, j]
    neighbours([i, j]).each do |(x, y)|
      @energy[x][y] += 1
      if @energy[x][y] > 9
        flash([x, y])
      end
    end
  end

  def neighbours((i, j))
    [
      [i - 1, j - 1],
      [i - 1, j],
      [i - 1, j + 1],
      [i, j - 1],
      [i, j],
      [i, j + 1],
      [i + 1, j],
      [i + 1, j - 1],
      [i + 1, j + 1],
    ].select do |(x, y)|
      x.between?(0, @energy.length - 1) &&
        y.between?(0, @energy.first.length - 1)
    end
  end
end

if __FILE__ == $0
  energy = DATA.each_line.map {|line| line.chomp.chars.map(&:to_i)}
  octapus_one = Octapus.new(energy)
  p "STEP ONE"
  octapus_one.pass_days(100)
  p octapus_one.flashes
  p "STEP TWO"
  octapus_two = Octapus.new(energy)
  puts octapus_two.first_full_flash
  puts octapus_two.to_s
end

__END__
4743378318
4664212844
2535667884
3273363861
2282432612
2166612134
3776334513
8123852583
8181786685
4362533174