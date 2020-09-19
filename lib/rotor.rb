class Rotor
    #attr_reader :setting

    #These connections were gathered from https://bit.ly/33EWSk6
    ROTOR_CONNECTIONS = [
        :EKMFLGDQVZNTOWYHXUSPAIBRCJ,
        :AJDKSIRUXBLHWTMCQGZNPYFVOE,
        :BDFHJLCPRTXVZNYEIWGAKMUSQO,
        :ESOVPZJAYQUIRHXLNFTGKDCMWB,
        :VZBRGITYUPSDNHLXAWMJQOFECK
    ]

    def initialize(id,pos="A")
        raise(ArgumentError,"Invalid rotor number.") unless [1,2,3,4,5].include?(id)
        @id = id
        set_position(pos)
    end

    def get_value(char)
        new_char = @setting.slice("ABCDEFGHIJKLMNOPQRSTUVWXYZ".index(char.upcase))
        rotate
        return new_char
    end

    def set_position(char)
        @setting = ROTOR_CONNECTIONS[@id-1]
        char = char.upcase
        ("ABCDEFGHIJKLMNOPQRSTUVWXYZ".index(char)).times {rotate}
    end

    private

    def rotate
        @setting = (@setting[1..-1]+@setting[0]).to_sym
    end

end