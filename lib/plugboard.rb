class Plugboard

    ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    def initialize(wires = nil)
        raise(ArgumentError,"Argument must be a hash") unless ((wires.is_a? Hash) || !wires)
        @plugs = Hash.new
        if wires
            wires.each do |pos1,pos2|
                @plugs[pos1] = pos2
                @plugs[pos2] = pos1
            end
        end
        fill_plugs
    end

    def add_wire(pos1,pos2)

    end

    def remove_wire(wire_num)

    end

    def get_wires
        ignore = Array.new
        wires = Hash.new

        plugs.each do |k,v|
            if k!=v
                if !ignore.include?(k)
                    ignore << v
                    wires[k] = v
                end
            end
        end
        return wires
    end

    def get_value(char)

    end

    private

    attr_accessor :plugs

    def fill_plugs
        ALPHA.each_char {|char| plugs[char]=char if !plugs.keys.include?(char)}
    end

    def num_wires_used
        get_wires.length
    end

end