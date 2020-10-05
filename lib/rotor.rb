class Rotor

    #These connections were gathered from https://bit.ly/33EWSk6
    WIRING_CONNECTIONS = [
        "EKMFLGDQVZNTOWYHXUSPAIBRCJ",
        "AJDKSIRUXBLHWTMCQGZNPYFVOE",
        "BDFHJLCPRTXVZNYEIWGAKMUSQO",
        "ESOVPZJAYQUIRHXLNFTGKDCMWB",
        "VZBRGITYUPSDNHLXAWMJQOFECK"
    ]

    NOTCH_WINDOWS = "QEVJZ" # 17, 5, 22, 10, 26

    ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    attr_reader :notch, :id

    def initialize(id,pos=1,ring_setting=1)
        raise(ArgumentError,"Invalid rotor number.") unless [1,2,3,4,5].include?(id)
        @id = id
        @notch = ALPHA.index(NOTCH_WINDOWS[id-1])+1
        @position = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        @ring_alpha = String.new
        @setting = Array.new
        adjust_ring_setting(ring_setting)
        go_to_pos(pos)
    end

    def get_value_from_right(char)
        raise(TypeError,"Character must be a letter.") unless char.is_a? String
        raise(ArgumentError,"Invalid character.") unless char.length == 1
        raise(ArgumentError,"Invalid character.") unless ALPHA.include?(char.upcase)
        input_pos = ALPHA.index(char.upcase)
        input_setting = @position[input_pos]
        output_setting = @setting[@ring_alpha.index(input_setting)][-1]
        output_pos = @position.index(output_setting)
        new_char = ALPHA[output_pos]
        return new_char
    end

    def get_value_from_left(char)
        raise(TypeError,"Character must be a letter.") unless char.is_a? String
        raise(ArgumentError,"Invalid character.") unless char.length == 1
        raise(ArgumentError,"Invalid character.") unless ALPHA.include?(char.upcase)
        input_pos = ALPHA.index(char.upcase)
        input_setting = @position[input_pos]
        output_setting = @setting[WIRING_CONNECTIONS[@id-1].index(input_setting)][0]
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

    def go_to_pos(new_pos)
        raise(ArgumentError,"Invalid rotor position") unless (1..26).include?(new_pos)
        if position == new_pos
            return position
        elsif position < new_pos
            moves_forward = new_pos - position
            moves_backward = position + 26 - new_pos
        else
            moves_backward = position - new_pos
            moves_forward = new_pos + 26 - position
        end

        if moves_forward < moves_backward
            moves_forward.times {rotate_forward}
        else
            moves_backward.times {rotate_backward}
        end
    end

    def adjust_ring_setting(ring_setting)
        first = ALPHA[27-ring_setting..-1]
        second = ALPHA[0..-1-first.length]
        @ring_alpha = first+second
        (0..25).each {|idx| @setting << [@ring_alpha[idx], WIRING_CONNECTIONS[@id-1][idx]]}
    end
end