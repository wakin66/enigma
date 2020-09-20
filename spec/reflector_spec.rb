require 'reflector'

describe Reflector do
    subject(:reflector) {Reflector.new("B")}

    describe "#initialize" do
        context "takes a string as an argument" do
            it "doesn't raise an error when given the string 'B' or 'C'." do
                expect {Reflector.new("B")}.to_not raise_error
                expect {Reflector.new("C")}.to_not raise_error
            end

            it "raises an error when given the wrong arguments" do
                expect {Reflector.new("D")}.to raise_error(ArgumentError,"Invalid reflector ID.")
            end

            it "raises an error when length != 1" do
                expect {Reflector.new("BC")}.to raise_error(ArgumentError,"Invalid reflector ID.")
            end
        end

        context "is given an argument that is NOT a string" do
            it "raises an error" do
                expect {Reflector.new(1)}.to raise_error(TypeError,"Reflector ID must be a letter.")
            end
        end
    end

    describe "#get_value" do
        context "is given a string as an argument" do
            it "doesn't raise an argument when length = 1" do
                expect {reflector.get_value("a")}.to_not raise_error
            end

            it "raises an error when length != 1" do
                expect {reflector.get_value("ab")}.to raise_error(ArgumentError,"Invalid character.")
            end

            it "raises an error when the string is not a letter" do
                expect {reflector.get_value("1")}.to raise_error(ArgumentError,"Invalid character.")
            end

            it "returns 'Y' when given the string 'A'" do
                expect(reflector.get_value("A")).to eq("Y")
            end

            it "returns 'A' when given the string 'Y'" do
                expect(reflector.get_value("Y")).to eq("A")
            end
        end

        context "is given an argument that is NOT a string" do
            it "raises an error" do
                expect {reflector.get_value(1)}.to raise_error(TypeError,"Character must be a letter.")
            end
        end
    end

end