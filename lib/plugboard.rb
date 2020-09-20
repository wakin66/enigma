class Plugboard

    def initialize(wires = nil)
        @plugs = Hash.new
        fill_wires(wires)
    end

    def add_wire(pos1,pos2)

    end

    def remove_wire(wire_num)

    end

    def get_wires

    end

    def get_value(char)

    end

    private

    def fill_wires(wires)

    end

    def num_wires_used
        get_wires.length
    end

end