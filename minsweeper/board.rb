require_relative "tile"

class Board
  NUMBER_OF_BOMBS = 10

  def self.empty_grid
    Array.new(9) do
      Array.new(9) { Tile.new }
    end
  end

  def initialize(grid = Board.empty_grid)
    @grid = grid
    place_bombs
    calculate_fringe
  end

  def bomb_count
    grid.flatten.select(&:is_bomb?).length
  end

  def place_bombs
    until bomb_count == NUMBER_OF_BOMBS
      pos =[rand(9),rand(9)]
      self[pos].bomb unless self[pos].is_bomb?
    end
  end

  def calculate_fringe
    (0...9).each do |i|
      (0...9).each do |j|
      p i
      p j
        # pos =
        if self[[i, j]].is_bomb?
          up = [i + 1, j]
          down = [i - 1, j]
          right = [i, j + 1]
          left = [i, j - 1]

          self[up].incrament_fringe if in_range?(up)

          self[down].incrament_fringe if in_range?(down)

          self[left].incrament_fringe if in_range?(left)

          self[right].incrament_fringe if in_range?(right)
        end
      end
    end
  end

  def render
    grid.each do |row|
      row.each do |tile|
        if tile.is_hidden? && tile.fringe.zero?
          print "*"
        else
          print tile.fringe
        end
      end
      puts
    end
  end

  def size
    grid.size
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  # def []=(pos, value)
  #   x, y = pos
  #   tile = grid[x][y]
  #   tile.fringe
  # end

  private

  attr_reader :grid

  def in_range?(pos)
    p pos
    x, y = pos
    x < 9 && y < 9 && x >= 0 && y >= 0
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b.render
  p b.bomb_count
end
