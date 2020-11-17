
require_relative 'tile'

class Board

    def self.the_grid(n)
        Array.new(n) { Array.new(n) { Tile.new(true) } }
    end

    attr_reader :grid

    def initialize(n)
        @grid = self.class.the_grid(n)
    end

    def render
       @grid.dup.each { |line| p line.each_with_index { |tile, i| tile.hidden ? line[i] = "*" : line[i] = "_" } }
    end

end