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

    def initialize(id,pos=0,ring_setting=1)
        raise(ArgumentError,"Invalid rotor.") unless (1..5).include?(id)
        raise(ArgumentError,"Invalid position.") unless (0..25).include?(pos)
        raise(ArgumentError,"Invalid ring setting.") unless (1..26).include?(ring_setting)
        @id = id
        @notch = ALPHA.index(NOTCH_WINDOWS[id-1])
        @ring_alpha = String.new
        @connections = Hash.new
        generate_forwards_connections
        generate_backwards_connections
        @offset = pos
        adjust_ring_setting(ring_setting) #adjusts the ring setting and sets the connections
    end

    def get_value(char,direction)
        input_pos = ALPHA.index(char.upcase)+offset
        input_pos -= 26 if input_pos > 25
        input_char = ring_alpha[input_pos]
        connection_char = connections[direction][input_char]
        output_pos = ring_alpha.index(connection_char)-offset
        output_pos += 26 if output_pos < 0
        output_char = ALPHA[output_pos]
        return output_char
    end

    def rotate_forward
        @offset += 1
        @offset = 0 if @offset == 26
        return offset
    end

    def rotate_backward
        @offset -= 1
        @offset = 25 if @offset == -1
        return offset
    end

    def adjust_ring_setting(ring_setting)
        first = ALPHA[27-ring_setting..-1]
        second = ALPHA[0..-1-first.length]
        @ring_alpha = first+second
    end

    def window #Letter to display on machine
        return ALPHA[offset]
    end

    private

    attr_reader :connections, :ring_alpha, :offset

    def generate_forwards_connections
        connections[:forward] = Hash.new
        ALPHA.each_char.with_index {|char,char_idx| connections[:forward][char] = WIRING_CONNECTIONS[id-1][char_idx]}
        return true
    end

    def generate_backwards_connections
        connections[:backward] = Hash.new
        ALPHA.each_char {|char| connections[:backward][char] = connections[:forward].key(char)}
        return true
    end
end