


class Tile

    attr_accessor :hidden

    def initialize(status)
        @bomb = bomb?
        @hidden = status
    end

    def bomb?
        [ false, false, false, false, true ].sample
    end

end