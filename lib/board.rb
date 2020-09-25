class Board

    ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    attr_reader :values

    def initialize
        @values = Array.new(16) {Array.new(17)}
        fill_board
    end

    def update_values(rotor_positions)
        row_idx = 6
        col_idx = [3,8,13]

        rotor_positions.each.with_index {|pos,idx| values[row_idx][col_idx[idx]] = ALPHA[pos-1]}
    end

    private

    attr_writer :values

    def fill_board
        row_12 = ["Q","W","E","R","T","Z","U","I","O"]
        row_13 = ["A","S","D","F","G","H","J","K"]
        row_14 = ["P","Y","X","C","V","B","N","M","L"]
        values.each.with_index do |row,row_idx|
            row.each_index do |col_idx|
                if row_idx == 12 && col_idx.even?
                    values[row_idx][col_idx] = row_12[col_idx/2]
                elsif row_idx == 13 && col_idx.odd?
                    values[row_idx][col_idx] = row_13[col_idx/2]
                elsif row_idx == 14 && col_idx.even?
                    values[row_idx][col_idx] = row_14[col_idx/2]
                else
                    values[row_idx][col_idx] = " "
                end
            end
        end
        return true
    end
end