
require_relative 'tile'

class Board

    def self.the_grid(n)
        Array.new(n) { Array.new(n) { Tile.new(true) } }
    end

    attr_reader :grid

    def initialize(n)
        @grid = self.class.the_grid(n)
        @dup = []
        row_key
        render
    end

    def row_key
        i = 1
        @grid.each { |row| row.insert(0, "#{i}") && i += 1 }
    end

    def col_key
        @dup.unshift((0..@grid[1].length - 1).to_a.join(' '))
    end

    def render
        @dup.clear
        col_key
        @grid.each { |line| @dup << line.map { |tile| tile.is_a?(String) ? tile : tile.hidden ? "*" : "_" }.join(' ') }
    end

    def print
        puts "\nMINESWEEPER"
        puts "\n"
        @dup.each { |line| puts line }
        puts "\n"
    end

    def reveal(position)
        @grid[position[0] - 1][position[1]].hidden = false
        render
        print
    end

end

board = Board.new(3)
board.render
board.print