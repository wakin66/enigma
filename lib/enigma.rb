require_relative 'plugboard'
require_relative 'reflector'
require_relative 'rotor'
require_relative 'board'
require_relative 'display'
require_relative 'keyboard'
require_relative 'string_alpha'

class Enigma

    ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    def initialize
        system('clear')
        @rotors = Array.new
        @plugboard = Plugboard.new
        @board = Board.new
        @keyboard = Keyboard.new
        @display = Display.new(board)
        if testing
            (1..3).each {|num| @rotors << Rotor.new(num)}
            @reflector = Reflector.new("B")
        else
            choose_rotors
            set_wires
            @reflector = choose_reflector
        end
    end

    def use_machine
        update_rotor_positions
        display.render
        while true
            key = keyboard.get_input
            ALPHA.include?(key.to_s) ? key = key.to_s : (return key)
            display.render(get_value(key))
        end
    end

    def get_input
        puts "Input the message you want encrypted:"
        print ">"
        input = gets.chomp.alpha
        output = ""
        input.each_char {|char| output += get_value(char)}
        puts output
        return output
    end

    def reset_rotors
        rotors.each {|rotor| rotor.go_to_pos(1)}
        update_rotor_positions
        return true
    end

    private

    attr_reader :board, :keyboard, :display, :rotors, :plugboard, :reflector

    def update_rotor_positions
        rotor_pos = Array.new
        rotors.each{|rotor| rotor_pos << rotor.window}
        board.update_values(rotor_pos)
    end

    def get_value(char)
        rotate
        update_rotor_positions
        temp_value = plugboard.get_value(char)
        temp_value = rotors[2].get_value_from_right(temp_value)
        temp_value = rotors[1].get_value_from_right(temp_value)
        temp_value = rotors[0].get_value_from_right(temp_value)
        temp_value = reflector.get_value(temp_value)
        temp_value = rotors[0].get_value_from_left(temp_value)
        temp_value = rotors[1].get_value_from_left(temp_value)
        temp_value = rotors[2].get_value_from_left(temp_value)
        new_value = plugboard.get_value(temp_value)
        return new_value
    end

    def choose_rotors
        puts "Please choose three rotors to use: (Default = 123)"
        print ">"
        input_rotors = gets.chomp.chars
        input_rotors.length == 3 ? input_rotors.map! {|x| x.to_i} : input_rotors = [1,2,3]
        puts "Please set the starting key settings: (Default = AAA)"
        print ">"
        input_pos = gets.chomp.chars
        input_pos.length == 3 ? input_pos.map! {|x| ALPHA.index(x.upcase)+1} : input_pos = [0,0,0]
        puts "Please set the ring settings: (Default = AAA)"
        print ">"
        input_ring_settings = gets.chomp.chars
        input_ring_settings.length == 3 ? input_ring_settings.map! {|x| ALPHA.index(x.upcase)+1} : input_ring_settings = [1,1,1]
        input_rotors.each.with_index {|rotor,idx| @rotors << Rotor.new(rotor,input_pos[idx],input_ring_settings[idx])}
        return rotors
    end

    def choose_reflector
        puts "Please choose which reflector to use: (B or C) (Default = B)"
        print ">"
        choice = gets.chomp
        choice = "B" if choice == ""
        return Reflector.new(choice)
    end

    def rotate
        rotors.each.with_index do |rotor, idx|
            rotor.rotate_forward if
                (idx == 2) || #Right most rotor
                (idx == 1 && rotor.notch == rotor.offset) || #Center rotor's notch is in position
                (rotors[idx+1].notch == rotors[idx+1].offset) #Rotor to the right's notch is in position
        end
    end

    def set_wires
        input = nil
        until input
            puts "Plugboard connections: (Default = none & max = 10)"
            puts "Example: AB CD EF GH IJ KL MN OP QR ST"
            print ">"
            input = gets.chomp.split
            input = nil if input.length > 10
        end
        input.each {|pair| plugboard.add_wire(pair)}
    end
end

if __FILE__ == $PROGRAM_NAME
    enigma = Enigma.new
    enigma.use_machine
    #enigma.get_input
end