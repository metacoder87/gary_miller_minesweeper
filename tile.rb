


class Tile

    attr_accessor :hidden, :flagged
    attr_reader :bomb

    def initialize(bomb)
        @bomb = bomb
        @hidden = true
        @flagged = false
    end

end