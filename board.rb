
require_relative 'tile'

class Board

    def self.the_grid(n)
        Array.new(n) { Array.new(n) { Tile.new(true) } }
    end

    attr_reader :grid

    def initialize(n)
        @grid = self.class.the_grid(n)
        row_key
    end

    def render(dup = [])
        @grid.each { |line| dup << line.map { |tile| tile.hidden ? "*" : "_" }.join(' ') }
        dup.each { |line| p line }
    end

end