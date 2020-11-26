
require_relative 'tile'

class Board

    def self.the_grid(n)
        arr = (0..n-1).to_a.unshift(n)
        grid = Array.new(n + 1) { arr = arr.rotate }
        grid.each_with_index do |line, idx|
            if line == grid.first
                next
            else line.map.with_index do |tile, i|
                    if i == 0
                        next
                    else grid[i][idx] = "*"
                    end
                end
            end
        end
    end

    attr_reader :grid, :tiled

    def initialize(n)
        @grid = self.class.the_grid(n)
        @tiled = tiles
        @neighbors = []
    end

    def tiles
        @grid.map do |line|
            if line == @grid.first
                line
            else line.map { |tile| tile == line.first ? tile : tile = Tile.new(true) }
            end
        end
    end

    def print
        puts "\nMINESWEEPER"
        puts "\n"
        @grid.each { |line| puts line.join(' ') }
        puts "\n"
    end

    def neighbors(position)
        neighborinos = []
        x = position[0]
        y = position[1]
        x_range = (x - 1..x + 1).to_a
        y_range = (y - 1..y + 1).to_a
        x_range.each do |xs|
            y_range.each do |ys|
                if @grid[xs][ys] == "*"
                    neighborinos << [xs, ys] if [xs, ys] != position && ![xs, ys].include?(0)
                end
            end
        end
        return neighborinos 
    end

    def bomb?(position)
        @tiled[position[0]][position[1]].bomb
    end

    def adjacent_bombs(position)
        neighbors(position).select { |neighbor| bomb?(neighbor) }.count
    end

    def hood_reveal
        until @neighbors.empty?
            neighbor = @neighbors.shift
            tile = @tiled[neighbor[0]][neighbor[1]]
            reveal(neighbor) if tile.hidden && !tile.bomb
        end
    end

    def reveal(position)  
        if @tiled[position[0]][position[1]].hidden
            @tiled[position[0]][position[1]].hidden = false
            if bomb?(position)
                game_over
            elsif adjacent_bombs(position) == 0
                @grid[position[0]][position[1]] = "_"
                @neighbors << neighbors(position)
                hood_reveal
            else @grid[position[0]][position[1]] = adjacent_bombs(position)
            end
        else puts "The position #{position} has already been revealed."
        end
        print
    end

    def game_over
        system 'clear'
        puts "WOMP WOMP"
        sleep(1) 
        puts "Game Over"
        sleep(3)
        system 'clear'
    end

end

board = Board.new(5)
board.print
board.neighbors([1,1])