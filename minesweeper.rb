
require "byebug"
require "yaml"
require_relative "board"

class MineSweeper

    attr_reader :board

    def initialize
        if File.exist?("saved.txt")
            if new_game?
                @board = Board.new(get_size, get_diff)
            else load_game
            end
        else @board = Board.new(get_size, get_diff)
        end
    end

    def new_game?
        status = nil
        until status && ['new', 'saved'].include?(status)
            puts "Should I load a 'new' or 'saved' game?"
            print "> "
            status = gets.chomp.to_s.downcase
        end
        if status == "new"
            return true
        else false
        end
    end

    def load_game
        @board = YAML::load(File.read("saved.txt"))
        File.delete("saved.txt")
    end
        

    def get_size
        size = nil
        until size && (1..99).include?(size)
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
            puts "Choose which location to sweep using (y, x)"
            puts "You can flag by including an F with the location."
            puts "Also you can choose S to save your game and come back later."
            print "> "
            choice = gets.chomp.downcase
        end

        if choice.include?(",")
            choice = choice.split(',')
        else choice = choice.split(' ')
        end

        if choice.any? { |part| part.include?("f") }
            choice = choice.map { |num| num == "f" ? next : num.include?("f") ? num.delete("f").to_i : num == " " ? next : num == "," ? next : num.to_i }.compact
            @board.flag(choice)
        elsif choice.include?("s")
            save_game
            system 'clear'
            puts "Your field has been saved."
            sleep(2)
            system 'clear'
            puts "Thanks for playing"
            sleep(2)
            system 'clear'
            exit
        else choice = choice.map { |num| num == " " ? next : num == "," ? next : num.to_i }.compact 
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
        exit
    end

    def save_game
        File.open("saved.txt", "w") { |file| file.write(@board.to_yaml) }
    end


    def play
        until @board.win?
            system 'clear'
            @board.print
            get_choice
        end
        win
    end

end

ms = MineSweeper.new
ms.play