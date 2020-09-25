require "io/console"

KEYMAP = {
  " " => :space,
  "A" => :A,
  "B" => :B,
  "C" => :C,
  "D" => :D,
  "E" => :E,
  "F" => :F,
  "G" => :G,
  "H" => :H,
  "I" => :I,
  "J" => :J,
  "K" => :K,
  "L" => :L,
  "M" => :M,
  "N" => :N,
  "O" => :O,
  "P" => :P,
  "Q" => :Q,
  "R" => :R,
  "S" => :S,
  "T" => :T,
  "U" => :U,
  "V" => :V,
  "W" => :W,
  "X" => :X,
  "Y" => :Y,
  "Z" => :Z,
#   "\t" => :tab,
#   "\r" => :return,
#   "\n" => :newline,
#   "\e" => :escape,
#   "\e[A" => :up,
#   "\e[B" => :down,
#   "\e[C" => :right,
#   "\e[D" => :left,
#   "\177" => :backspace,
#   "\004" => :delete,
  "\u0003" => :ctrl_c,
}

class Keyboard

    attr_reader :cursor_pos, :board

    def initialize
    end

    def get_input
        key = KEYMAP[read_char.upcase]
        handle_key(key)
    end

    private

    def read_char
        STDIN.echo = false # stops the console from printing return values

        STDIN.raw! # in raw mode data is given as is to the program--the system
                    # doesn't preprocess special characters such as control-c

        input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                                # numeric keycode. chr returns a string of the
                                # character represented by the keycode.
                                # (e.g. 65.chr => "A")

        if input == "\e" then
        input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                    # at most maxlen bytes from a
                                                    # data stream; it's nonblocking,
                                                    # meaning the method executes
                                                    # asynchronously; it raises an
                                                    # error if no data is available,
                                                    # hence the need for rescue

        input << STDIN.read_nonblock(2) rescue nil
        end

        STDIN.echo = true # the console prints return values again
        STDIN.cooked! # the opposite of raw mode :)

        return input
    end

    def handle_key(key)
        case key
        when :ctrl_c
            exit 0
        else
            return key
        end
    end
end