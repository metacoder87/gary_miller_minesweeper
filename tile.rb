


class Tile

    attr_accessor :hidden, :flagged
    attr_reader :bomb

    def initialize(bomb)
        @bomb = bomb
        @hidden = true
        @flagged = false
    end

    # def bomb?
    #     Array.new(7,false).push(true).sample
    # end

end