class HeightMap 
  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def []((x, y))
    @grid[x][y]
  end
  
  def low_point?(point)
    neighbours(point).all? { |n| self[n] > self[point] }
  end

  def low_points
    lows = []
    @grid.each_with_index do |row, i|
      row.each_with_index do |col, j|
        lows << [i, j] if low_point?([i , j])
      end
    end
    lows 
  end

  def low_point_values
    low_points.map { |n| self[n] }
  end

  def risk_levels
    low_point_values.map { |p| p + 1 }.inject(:+)
  end 

  def neighbours((i, j))
    [
      [i, j - 1],
      [i, j + 1],
      [i - 1, j],
      [i + 1, j],
    ].select do |(x, y)|
      x.between?(0, @grid.length - 1) &&
        y.between?(0, @grid.first.length - 1)
    end
  end
end 

if __FILE__ == $0
  grid = File.readlines(ARGV.first).map(&:chomp).map { _1.chars.map(&:to_i) } 
  map = HeightMap.new(grid)

  # Part One
  puts map.risk_levels
end 