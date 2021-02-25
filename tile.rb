


class Tile

    attr_accessor :hidden
    attr_reader :bomb

    def initialize(status)
        @bomb = bomb?
        @hidden = status
    end

    def bomb?
        Array.new(9,false).push(true).sample
    end

end