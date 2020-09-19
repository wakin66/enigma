class Rotor

    #These connections were gathered from https://bit.ly/33EWSk6
    WIRING_CONNECTIONS = [
        :EKMFLGDQVZNTOWYHXUSPAIBRCJ,
        :AJDKSIRUXBLHWTMCQGZNPYFVOE,
        :BDFHJLCPRTXVZNYEIWGAKMUSQO,
        :ESOVPZJAYQUIRHXLNFTGKDCMWB,
        :VZBRGITYUPSDNHLXAWMJQOFECK
    ]

    ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    def initialize(id,pos=1)
        raise(ArgumentError,"Invalid rotor number.") unless [1,2,3,4,5].include?(id)
        @id = id
        @position = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        @setting = WIRING_CONNECTIONS[@id-1]
        got_to_pos(pos)
    end

    def get_value(char)
        raise(TypeError,"Character must be a letter.") unless char.is_a? String
        raise(ArgumentError,"Invalid character.") unless char.length == 1
        raise(ArgumentError,"Invalid character.") unless ALPHA.include?(char.upcase)
        input_pos = ALPHA.index(char.upcase)
        input_setting = @position[input_pos]
        output_setting = @setting.slice(ALPHA.index(input_setting))
        output_pos = @position.index(output_setting)
        new_char = ALPHA[output_pos]
        return new_char
    end

    def position
        return ALPHA.index(@position[0])+1
    end

    def rotate_forward
        @position = @position[1..-1]+@position[0]
        return position
    end

    def rotate_backward
        @position = @position[-1]+@position[0...-1]
        return position
    end

    private

    def got_to_pos(new_pos)
        if position == new_pos
            return position
        elsif position < new_pos
            moves_forward = new_pos - position
            moves_backward = position + 26 - new_pos
        else
            moves_forward = position - new_pos
            moves_backward = new_pos + 26 - position
        end
        if moves_forward < moves_backward
            moves_forward.times {rotate_forward}
        else
            moves_backward.times {rotate_backward}
        end
    end

end