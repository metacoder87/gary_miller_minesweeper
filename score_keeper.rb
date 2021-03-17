class ScoreKeeper

    attr_reader :scores
    def initialize(name, size, difficulty, time)
        @name = name
        @size = size
        @time = time
        @difficulty = difficulty
    end

    def sub_score
        { @name => [@difficulty, @size, @time] }
    end

    def high_scores
        @scores = YAML::load(File.read("high_scores.txt"))
    end
