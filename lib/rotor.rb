class Rotor
    #attr_reader :setting

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
        set_position(pos)
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
        rotate
        return new_char
    end

    def set_position(pos)
        raise(ArgumentError,"Invalid rotor position") unless (1..26).include?(pos)
        (pos-1).times {rotate}
    end

    private

    def rotate
        @position = @position[1..-1]+@position[0]
    end

end