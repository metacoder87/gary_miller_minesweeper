

require_relative "board"

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
            choice = gets.chomp.downcase.split()
        end
        if choice.include?("f")
            choice = choice.map { |num| num == "f" ? next : num.to_i }.compact
            @board.flag(choice)
        else choice = choice.map { |num| num.to_i } 
            @board.reveal(choice)
        end
    end

    def win
        system 'clear'
        puts "WOO HOO YOU WON!!"
        sleep(1) 
        puts "YOU HAVE SWEPT ALL OF THE MINES, THE FIELD IS CLEAR"
        sleep(3)
        system 'clear'
    end

    def play
        until @board.win?
            @board.print
            get_choice
        end
        win
    end

end

ms = MineSweeper.new
ms.play