require_relative 'plugboard'
require_relative 'reflector'
require_relative 'rotor'
require_relative 'board'
require_relative 'display'
require_relative 'keyboard'

class Enigma

    ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    def initialize
        system('clear')
        @rotors = Array.new
        choose_rotors
        @plugboard = Plugboard.new
        @reflector = choose_reflector
        @board = Board.new
        @keyboard = Keyboard.new
        @display = Display.new(board)
        use_machine
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

    def reset_rotors
        rotors.each {|rotor| rotor.go_to_pos(1)}
        update_rotor_positions
        return true
    end

    private

    attr_reader :board, :keyboard, :display, :rotors, :plugboard, :reflector

    def update_rotor_positions
        rotor_pos = Array.new
        rotors.each{|rotor| rotor_pos << rotor.position}
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
        input_rotors = gets.chomp.chars.reverse
        input_rotors.length == 3 ? input_rotors.map! {|x| x.to_i} : input_rotors = [1,2,3]
        puts "Please set the starting key settings: (Default = AAA)"
        print ">"
        input_pos = gets.chomp.chars.reverse
        input_rotors.length == 3 ? input_rotors.map! {|x| ALPHA.index(x.upcase)} : input_rotors = [1,1,1]
        puts "Please set the ring settings: (Default = AAA)"
        print ">"
        input_ring_settings = gets.chomp.chars.reverse
        input_rotors.length == 3 ? input_rotors.map! {|x| ALPHA.index(x.upcase)} : input_rotors = [1,1,1]
        input_rotors.each {|rotor| @rotors << Rotor.new(rotor)}
        return rotors
    end

    def choose_reflector
        puts "Please choose which reflector to use: (B or C)"
        print ">"
        choice = gets.chomp
        return Reflector.new(choice)
    end

    def rotate
        rotors.each.with_index do |rotor, idx|
            rotor.rotate_forward if
                (idx == 2) || #Right most rotor
                (idx == 1 && rotor.notch == rotor.position) || #Center rotor's notch is in position
                (rotors[idx+1].notch == rotors[idx+1].position) #Rotor to the right's notch is in position
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    enigma = Enigma.new
    enigma.use_machine
end