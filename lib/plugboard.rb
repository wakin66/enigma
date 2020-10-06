class Plugboard

    ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    def initialize(wires = nil)
        raise(ArgumentError,"Argument must be a String") unless ((wires.is_a? String) || !wires)
        @plugs = Hash.new
        initialize_plugs(wires) if wires
        fill_plugs
    end

    def add_wire(pair)
        raise(ArgumentError,"Arguments must be Strings") unless pair.is_a? String
        raise(ArgumentError,"Arguments must be a pair of letters") unless pair.length == 2
        raise(RuntimeError,"All wires are being used") if num_wires_used == 10
        pair = pair.chars
        plugs[pair.first.upcase] = pair.last.upcase
        plugs[pair.last.upcase] = pair.first.upcase
        return get_wires
    end

    def remove_wire(wire_num)
        raise(RuntimeError,"There are no wires currently being used") if num_wires_used == 0
        raise(ArgumentError,"That wire number does not exist") unless (1..10).include?(wire_num)
        raise(RuntimeError,"That wire is not being used") if num_wires_used < wire_num
        get_wires.to_a[wire_num-1].each {|x| plugs[x] = x}
    end

    def get_wires
        ignore = Array.new
        wires = Hash.new

        plugs.each do |k,v|
            if k!=v && !ignore.include?(k)
                ignore << v
                wires[k] = v
            end
        end
        return wires
    end

    def get_value(char)
        raise(ArgumentError,"Argument must be a String") unless char.is_a? String
        raise(ArgumentError,"Argument must be a single letter") unless char.length == 1
        raise(ArgumentError,"Argument must be a letter") unless ALPHA.include?(char.upcase)
        return plugs[char.upcase]
    end

    private

    attr_accessor :plugs

    def fill_plugs
        ALPHA.each_char {|char| plugs[char]=char if !plugs.keys.include?(char)}
    end

    def num_wires_used
        get_wires.length
    end

    def initialize_plugs(wires)
        wires = wires.split
        wires.each {|pair| add_wire(pair)}
    end

end