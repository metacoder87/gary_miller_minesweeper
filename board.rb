
require_relative 'tile'

class Board

    def self.the_grid(n)
        Array.new(n) { Array.new(n) { Tile.new(true) } }
    end

    attr_reader :grid

    def initialize(n)
        @grid = self.class.the_grid(n)
        row_key
    def row_key
        i = 1
        @grid.each { |row| row.insert(0, "#{i}") && i += 1 }
    end

    def col_key
        @dup.unshift((0..@grid[1].length - 1).to_a.join(' '))
    end

    end

    def render(dup = [])
        @grid.each { |line| dup << line.map { |tile| tile.hidden ? "*" : "_" }.join(' ') }
        dup.each { |line| p line }
    end

end