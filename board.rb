
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

#     def neighbors(position)
#         neighborinos = []
#         x = position[0]
#         y = position[1]
#         x_range = (x - 1..x + 1).to_a
#         y_range = (y - 1..y + 1).to_a
#         x_range.each do |xs|
#             y_range.each do |ys|
#                 if [xs, ys].include?(0)
#                     next
#                 elsif [xs, ys] == position
#                 else neighborinos << [xs, ys]
#                 end
#             end
#         end
#         neighborinos 
#     end

#     def bomb?(position)
#         @grid[position[0]][position[1]].bomb
#     end

#     def adjacent_bombs(position)
#         neighbors(position).select { |neighbor| bomb?(neighbor) }.count
#     end

#     def hood_reveal(position)
#         neighbors(position).each do |neighbor| 
#             if adjacent_bombs(neighbor) == 0 
#                 reveal(neighbor)
#             else @grid[neighbor[1] - 1][neighbor[0]] = adjacent_bombs(neighbor).to_s
#             end
#         end
#     end

#     def reveal(position)
#         @grid[position[1] - 1][position[0]].hidden = false
#         hood_reveal(position)
#         render
#         print
#         game_over?
#     end

#     def game_over?
#         @grid.each do |line| 
#             line.each do |tile| 
#                 if tile.is_a?(String)
#                     next
#                 elsif tile.hidden == false && tile.bomb
#                     system 'clear'
#                     puts "WOMP WOMP"
#                     sleep(1) 
#                     puts "Game Over"
#                     sleep(3)
#                     system 'clear'
#                 else false
#                 end
#             end
#         end
#     end

end

# board = Board.new(5)
# board.render
# board.print
# board.neighbors([1,1])