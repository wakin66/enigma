class Reflector

#These connections were gathered from https://bit.ly/33EWSk6
    REFLECTOR_CONNECTIONS = [
        :YRUHQSLDPXNGOKMIEBFZCWVJAT,
        :FVPJIAOYEDRZXWGCTKUQSBNMHL
    ]

    def initialize(id)
        raise(TypeError,"Reflector ID must be a letter.") unless id.is_a? String
        raise(ArgumentError,"Invalid reflector ID.") unless id.length == 1
        raise(ArgumentError,"Invalid reflector ID.") unless "AB".include?(id.upcase)
        @id = id
        @setting = REFLECTOR_CONNECTIONS["AB".index(id.upcase)]
    end

    def get_value(char)
        raise(TypeError,"Character must be a letter.") unless char.is_a? String
        raise(ArgumentError,"Invalid character.") unless char.length == 1
        raise(ArgumentError,"Invalid character.") unless "ABCDEFGHIJKLMNOPQRSTUVWXYZ".include?(char.upcase)
        @setting.slice("ABCDEFGHIJKLMNOPQRSTUVWXYZ".index(char.upcase))
    end

end