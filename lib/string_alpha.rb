class String

    def alpha
        temp_arr = self.chars
        temp_arr.keep_if {|char| cahr.match?(/[A-Za-z]*/)}
        temp_arr.join
    end

end