


require 'yaml'

class ScoreKeeper

    attr_reader :scores, :name, :size, :difficulty, :time

    def initialize(name, size, difficulty, time)
        @name = name
        @size = size
        @time = time
        @difficulty = difficulty
        @scores = {}
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

    def top_scores
        @scores.select { |key, value| value.first == @difficulty && value[1] == @size }.sort_by { |score| score[1] }.first(10)
    end
    def save_scores
        File.open("high_scores.txt", "w") { |file| file.write(@scores.to_yaml) }
    end

end