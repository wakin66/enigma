require 'rotor'

describe Rotor do
    subject(:rotor) {Rotor.new(1)}

    describe "#initialize" do
        context "takes an integer as an argument" do
            it "doesn't raise an argument when given an integer within [1,2,3,4,5]" do
                expect {Rotor.new(1)}.to_not raise_error
                expect {Rotor.new(2)}.to_not raise_error
                expect {Rotor.new(3)}.to_not raise_error
                expect {Rotor.new(4)}.to_not raise_error
                expect {Rotor.new(5)}.to_not raise_error
            end

            it "raises an error when given the wrong arguments" do
                expect {Rotor.new(6)}.to raise_error(ArgumentError,"Invalid rotor number.")
            end
        end

        context "is given an argument that is NOT an integer" do
            it "raises an error" do
                expect {Rotor.new("one")}.to raise_error(ArgumentError,"Invalid rotor number.")
            end
        end
    end

    describe "#get_value" do
        context "is given a string as an argument" do
            it "doesn't raise an argument when length = 1" do
                expect {rotor.get_value("a")}.to_not raise_error
            end

            it "raises an error when length != 1" do
                expect {rotor.get_value("ab")}.to raise_error(ArgumentError,"Invalid character.")
            end

            it "raises an error when the string is not a letter" do
                expect {rotor.get_value("1")}.to raise_error(ArgumentError,"Invalid character.")
            end

            it "returns 'E' when given the string 'A'" do
                expect(rotor.get_value("A")).to eq("E")
            end

            it "returns 'C' when given the string 'Y'" do
                expect(rotor.get_value("Y")).to eq("C")
            end
        end

        context "is given an argument that is NOT a string" do
            it "raises an error" do
                expect {reflector.get_value(1)}.to raise_error(TypeError,"Character must be a letter.")
            end
        end
    end

end