class Reflector

#These connections were gathered from https://bit.ly/33EWSk6
    REFLECTOR_CONNECTIONS = [
        :YRUHQSLDPXNGOKMIEBFZCWVJAT,
        :FVPJIAOYEDRZXWGCTKUQSBNMHL
    ]

    def initialize(id)
        raise(ArgumentError,"Invalid rotor ID.") unless "AB".include?(id)
        @id = id
        @setting = REFLECTOR_CONNECTIONS["AB".index(id.upcase)]
    end

    def get_value(char)
        @setting.slice("ABCDEFGHIJKLMNOPQRSTUVWXYZ".index(char.upcase))
    end

end