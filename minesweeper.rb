


class MineSweeper

    def initialize
    def get_size
        size = nil
        until size && (1..10).include?(size)
            puts "What size board would you like to sweep for mines? (You can say, 3, 6, 9, 12...)"
            print "> "
            size = gets.chomp.to_i
        end
        size
    end
            
    end

    def get_dif

    end

end