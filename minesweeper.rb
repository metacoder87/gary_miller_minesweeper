


class MineSweeper

    attr_reader :board

    def initialize
        @board = Board.new(get_size, get_diff)
    end

    def get_size
        size = nil
        until size && (1..10).include?(size)
            puts "What size board would you like to sweep for mines? (You can say, 3, 6, 9, 12...)"
            print "> "
            size = gets.chomp.to_i
        end
        size
    end

    def get_diff
        diff = nil
        until diff && ["easy", "medium", "hard"].include?(diff)
            puts "Difficulty? (easy, medium, or hard)"
            print "> "
            diff = gets.chomp.to_s.downcase
        end
        diff
    end

    def get_choice  
        choice = nil
        until choice
            puts "Choose which location to sweep or flag."
            print "> "
            choice = gets.chomp.to_a
        end
        choice
    end

end