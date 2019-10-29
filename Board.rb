require_relative "Card"

class Board
  def initialize(n)
    @grid = Array.new(4) { Array.new(4) }
    @size = n * n
    populate_grid
  end

  def [](position)
    @grid[position[0]][position[1]]
  end

  def []=(position, value)
    @grid[position[0]][position[1]] = value
  end

  def populate_array
    letters = []
    alphabet = ('a'..'z').to_a
    8.times do
      letter = alphabet.pop.capitalize
      2.times do
        letters << letter
      end
    end
    letters
  end

  def populate_grid
    letters = populate_array.shuffle
    (0..3).each do |sub_array|
      (0..3).each do |ele|
        @grid[sub_array][ele] = Card.new(letters.pop)
      end
    end
  end

  def render
    system("clear")
    print "#{" "} "
    (0..3).each { |num| print "#{num} " }
    puts
    @grid.each.with_index do |row, i|
      print "#{i} "
      row.each do |card|
        print "#{card} "
      end
      puts
    end
  end

  def reveal_pos(position)
    self[position].reveal
  end

  def win?
    @grid.all? do |row|
      row.all?(&:revealed?)
    end
  end

  # def reveal_card(position)
  #   self.[](position).reveal
  # end
end

# board1 = Board.new
# board1.populate_grid
# board1.render
# board1.won?
