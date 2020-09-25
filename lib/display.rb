require_relative 'board'
require 'colorize'

class Display

    attr_reader :board

    def initialize(board)
        @board = board
        @background_color = Array.new(16) {Array.new(17)}
        setup_background
    end

    def render(char = nil)
        system('clear')
        char_background = :yellow
        board.values.each.with_index do |row,idx_x|
            row.each.with_index do |sqr,idx_y|
                if sqr == char && idx_x != 6
                    print " #{sqr} ".black.colorize(:background => char_background)
                else
                    print " #{sqr} ".black.colorize(:background => @background_color[idx_x][idx_y])
                end
            end
            puts
        end
        return nil
    end

    private

    def setup_background
        @background_color.each.with_index do |row,row_idx|
            row.each_index do |col_idx|
                if [3,9].include?(row_idx) && [3,8,13].include?(col_idx)
                    @background_color[row_idx][col_idx] = :light_black
                elsif (4..8).include?(row_idx) && [2,3,4,7,8,9,12,13,14].include?(col_idx)
                    @background_color[row_idx][col_idx] = :light_black
                elsif [12,14].include?(row_idx) && col_idx.even?
                    @background_color[row_idx][col_idx] = :light_black
                elsif row_idx == 13 && col_idx.odd?
                    @background_color[row_idx][col_idx] = :light_black
                else
                    @background_color[row_idx][col_idx] = :black
                end
            end
        end
        return true
    end
end