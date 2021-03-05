


class Tile

    attr_accessor :hidden, :flagged
    attr_reader :bomb

    def initialize(status)
        @bomb = bomb?
        @hidden = status
        @flagged = false
    end

    def bomb?
        Array.new(7,false).push(true).sample
    end

end