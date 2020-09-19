require 'rotor'

describe Rotor do
    subject(:rotor) {Rotor.new(1)}

    describe "#initialize" do
        context "takes an integer as an argument" do
            it "doesn't raise an argument when given an integer within [1,2,3,4,5]"

            it "raises an error when given the wrong arguments"
        end

        context "is given an argument that is NOT a string" do
            it "raises an error"
        end
    end

    describe "#get_value" do
        context "is given a string as an argument" do
            it "doesn't raise an argument when length = 1"

            it "raises an error when length != 1"

            it "raises an error when the string is not a letter"

            it "returns 'E' when given the string 'A'"

            it "returns 'C' when given the string 'Y'"
        end

        context "is given an argument that is NOT a string" do
            it "raises an error"
        end
    end

end