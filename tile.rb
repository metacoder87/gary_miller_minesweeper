


class Tile

    attr_accessor :revealed?

    attr_reader :bomb

    def initialize
        @bomb = bomb?
        @hidden? = true
    end

    def bomb?
        [ false, false, false, false, true ].sample
    end

end