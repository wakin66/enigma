require 'reflector'

describe Reflector do
    subject(:reflector) {Reflector.new("a")}

    describe "#initialize" do
        context "takes a string as an argument" do
            it "doesn't raise an argument when given the string 'a' or 'b'."

            it "raises an error when given the wrong arguments"

            it "raises an error when length != 1"
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

            it "returns 'Y' when given the string 'A'"

            it "returns 'A' when given the string 'Y'"
        end

        context "is given an argument that is NOT a string" do
            it "raises an error"
        end
    end

end