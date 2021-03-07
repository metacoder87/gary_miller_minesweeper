


require 'byebug'
require 'colorize'

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
        @hood = []
    end

    def tiles
        @grid.map do |line|
            if line == @grid.first
                line
            else line.map { |tile| tile == line.first ? tile : tile = Tile.new }
            end
        end
    end

    def print
        puts "\nMINESWEEPER"
        puts "\n"
        @grid.each_with_index do |line, idx| 
            puts line.map.with_index { |tile, i| tile == "*" ? tile.green : tile == "_" ? tile.black : idx == 0 ? tile.to_s.red : i == 0 ? tile.to_s.red : tile == "F" ? tile.to_s.blue : tile }.join(' ')
        end
        puts "\n"
        return true
    end

    def reveal(position)
        # debugger
        if @tiled[position[0]][position[1]].flagged
                puts "Can not reveal this position while it is Flagged."
        elsif @tiled[position[0]][position[1]].hidden 
            @tiled[position[0]][position[1]].hidden = false
            if bomb?(position)
                game_over
            elsif adjacent_bombs(position) == 0
                @grid[position[0]][position[1]] = "_"
                hood_fill(position)
                hood_reveal
            else adjacent_reveal(position)
            end
        else puts "The position #{position} has already been revealed."
        end
        print
    end

    def neighbors(position)
        neighborinos = []
        x = position[0]
        y = position[1]
        x_range = []
        y_range = []
        if x > 1 && y > 1 && x < @grid.first.length - 1 && y < @grid.first.length - 1
            x_range = (x - 1..x + 1).to_a
            y_range = (y - 1..y + 1).to_a
        elsif x == 1 && y > 1 && y < @grid.first.length - 1
            x_range = (x..x + 1).to_a
            y_range = (y - 1..y + 1).to_a
        elsif x > 1 && x < @grid.first.length - 1 && y == 1
            x_range = (x - 1..x + 1).to_a
            y_range = (y..y + 1).to_a
        elsif x == 1 && y == 1
            x_range = (x..x + 1).to_a
            y_range = (y - 1..y + 1).to_a
        elsif x == @grid.first.length - 1 && y > 1 && y < @grid.first.length - 1
            x_range = (x - 1..x).to_a
            y_range = (y - 1..y + 1).to_a
        elsif x > 1 && x < @grid.first.length - 1 && y == @grid.first.length - 1
            x_range = (x - 1..x + 1).to_a
            y_range = (y - 1..y).to_a
        elsif x == @grid.first.length - 1 && y == @grid.first.length - 1
            x_range = (x - 1..x).to_a
            y_range = (y - 1..y).to_a
        elsif x == 1 && y == @grid.first.length - 1
            x_range = (x..x + 1).to_a
            y_range = (y - 1..y).to_a
        elsif x == @grid.first.length - 1 && y == 1
            x_range = (x - 1..x).to_a
            y_range = (y..y + 1).to_a
        else puts "Does not compute. Try again."
        end
        # debugger
        x_range.each do |xs|
            y_range.each do |ys|
                if @grid[xs][ys] == "*" && !@hood.include?([xs, ys])
                    neighborinos << [xs, ys] if [xs, ys] != position && @grid[xs][ys] == "*"
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

    def adjacent_reveal(position)
        @grid[position[0]][position[1]] = adjacent_bombs(position)
        @tiled[position[0]][position[1]].hidden = false
    end

    def hood_fill(position)
        neighbors(position).select { |neighbor| adjacent_bombs(neighbor) < 1 ? @hood << neighbor : adjacent_reveal(neighbor) }
    end

    def hood_reveal
        until @hood.empty?
            neighbor = @hood.shift
            tile = @tiled[neighbor[0]][neighbor[1]]
            reveal(neighbor) if tile.hidden && !tile.bomb && !tile.flagged
        end
    end

    def flag(position)
        if @grid[position[0]][position[1]] == "*"
            @grid[position[0]][position[1]] = "F"
            @tiled[position[0]][position[1]].flagged = true
        elsif @grid[position[0]][position[1]] == "F"
            @grid[position[0]][position[1]] = "*"
            @tiled[position[0]][position[1]].flagged = false
        else puts "Can not Flag that square."
        end
        print
    end

    def win?
        @tiled[1..-1].map { |row| row[1..-1].select { |tile| tile.hidden }.count }.sum == @tiled[1..-1].map { |row| row[1..-1].select { |tile| tile.bomb }.count }.sum
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