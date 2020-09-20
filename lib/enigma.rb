require_relative 'plugboard'
require_relative 'reflector'
require_relative 'rotor'

class Enigma

    def initialize
        @rotors = Array.new
        choose_rotors
        @plugboard = Plugboard.new
        @reflector = choose_reflector
    end

    def get_value(char)
        rotate
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

    def reset_rotors
        rotors.each {|rotor| rotor.go_to_pos(1)}
    end

    #private

    attr_reader :rotors, :plugboard, :reflector

    def choose_rotors
        puts "Please choose three rotors to use: (1,2,3,4,5)"
        print ">"
        input = gets.chomp.split(",").map {|x| x.to_i}
        input.each {|x| @rotors << Rotor.new(x)}
        return rotors
    end

    def choose_reflector
        puts "Please choose which reflector to use: (B or C)"
        print ">"
        choice = gets.chomp
        return Reflector.new(choice)
    end

    def rotate
        rotors.each.with_index {|rotor, idx| rotor.rotate_forward if (idx == 2) || (rotors[idx+1].notch == rotors[idx+1].position)}
    end
end