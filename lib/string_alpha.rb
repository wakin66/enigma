ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

class String

    def alpha
        temp_arr = self.chars
        temp_arr.keep_if {|char| ALPHA.include?(char.upcase)}
        temp_arr.join
    end

end