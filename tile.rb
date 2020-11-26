


class Tile

    attr_accessor :hidden
    attr_reader :bomb

    def initialize(status)
        @bomb = bomb?
        @hidden = status
    end

    def bomb?
        [false, false, false, false, false, true ].sample
    end

end