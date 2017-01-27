class Tile
  attr_accessor :fringe

  def initialize(is_bomb = false)
    @bomb = is_bomb
    @hidden = true
    @flagged = false
    @fringe = 0
  end

  def incrament_fringe
    @fringe += 1
  end

  def is_hidden?
    @hidden
  end

  def is_bomb?
    @bomb
  end

  def bomb
    @bomb = true
  end

  def reveal
    @hidden = false
  end

  def is_flagged?
    @flagged
  end

  def flag
    @flagged = (is_flagged? ? false : true)
  end
end
