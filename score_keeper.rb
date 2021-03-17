class ScoreKeeper

    def initialize(name, size, difficulty, time)
        @name = name
        @size = size
        @time = time
        @difficulty = difficulty
    end

    def sub_score
        { @name => [@difficulty, @size, @time] }
    end
