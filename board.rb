


class Board

    def self.the_grid(n)
        Array.new(n) { Array.new(n) { Tile.new() } }
    end

    attr_reader :grid

    def initialize(n)
        @grid = self.class.the_grid(n)
    end

    def render
        grid.each { |row| puts row }
    end

end