


require 'yaml'

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

    def add_score
        @scores.store(@name, [@difficulty, @size, @time])
    end

    def save_scores
        File.open("high_scores.txt", "w") { |file| file.write(@scores.to_yaml) }
    end

end