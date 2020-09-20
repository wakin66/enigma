require 'plugboard'

describe Plugboard do
    subject(:plugboard) {Plugboard.new}

    describe "#initialize" do
        it "raises an error if the argument is not a Hash or nil" do
            expect {Plugboard.new(5)}.to raise_error(ArgumentError,"Argument must be a hash")
        end
    end

    describe "#add_wire" do
        context "when there is at least one unused wire" do
            context "and is called correctly" do
                it "takes two Strings as arguments" do
                    expect {plugboard.add_wire("a","y")}.to_not raise_error
                end

                it "returns the new key_value pairs {:x => :y,:y => :x}" do
                    expect(plugboard.add_wire("a","y")).to eq({"a"=>"y", "y"=>"a"})
                end
            end

            context "and is not called correctly" do

                it "raises an error if only one String is given" do
                    expect {plugboard.add_wire("a")}.to raise_error(ArgumentError, "wrong number of arguments (given 1, expected 2)")
                end

                it "raises an error if more than two Strings are given" do
                    expect {plugboard.add_wire("a","b","c")}.to raise_error(ArgumentError, "wrong number of arguments (given 3, expected 2)")
                end

                it "raises an error if something other than a String is given" do
                    expect {plugboard.add_wire("a","y")}.to raise_error(ArgumentError,"Arguments must be Strings")
                end

                it "raises an error if an Argument length != 1" do
                    expect {plugboard.add_wire("ab","y")}.to raise_error(ArgumentError,"Arguments must be a single letter")
                end
            end
        end

        context "when there are no unused wires" do
            it "raises an error" do
                plugboard.add_wire("a","b")
                plugboard.add_wire("c","d")
                plugboard.add_wire("e","f")
                plugboard.add_wire("g","h")
                plugboard.add_wire("i","j")
                plugboard.add_wire("k","l")
                plugboard.add_wire("m","n")
                plugboard.add_wire("o","p")
                plugboard.add_wire("q","r")
                plugboard.add_wire("s","t")
                expect {plugboard.add_wire("y","z")}.to raise_error(RuntimeError,"All wires are being used")
            end
        end
    end

    describe "#remove_wire" do
        context "when there is at least one used wire" do
            context "and it is called correctly" do
                it "takes an Integer as an argument" do
                    plugboard.add_wire("a","b")
                    expect {plugboard.remove_wire(1)}.to_not raise_error
                end
            end

            context "and it is not called correctly" do
                it "raises an error if the wire is empty" do
                    plugboard.add_wire("a","b")
                    expect {plugboard.remove_wire(5)}.to raise_error(RuntimeError,"That wire is not being used")
                end

                it "raises an error if the Integer is not between 1 and 10 inclusive" do
                    plugboard.add_wire("a","b")
                    expect {plugboard.remove_wire(15)}.to raise_error(ArgumentError,"That wire number does not exist")
                end
            end
        end

        context "when there are no used wires" do
            it "raises an error" do
                expect {plugboard.remove_wire(1)}.to raise_error(RuntimeError,"There are no wires currently being used")
            end
        end
    end

    describe "#get_wires" do
        it "returns a Hash" do
            expect(plugboard.get_wires).to be_a(Hash)
        end
    end

    describe "#get_value" do
        context "when given a String as an argument" do
            it "raises an error if String length != 1" do
                expect {plugboard.get_value("AB")}.to raise_error(ArgumentError,"Argument must be a single letter")
            end

            it "raises an error if String is not a letter" do
                expect {plugboard.get_value("1")}.to raise_error(ArgumentError,"Argument must be a single letter")
            end

            it "returns 'Y' if given 'A'" do
                expect(plugboard.get_value("A")).to eq("Y")
            end

            it "returns 'A' if given 'Y'" do
                expect(plugboard.get_value("Y")).to eq("A")
            end

            it "returns 'B' if given 'B'" do
                expect(plugboard.get_value("B")).to eq("B")
            end
        end

        context "when the given argument that is NOT a String" do
            it "raises an error" do
                expect {plugboard.get_value(1)}.to raise_error(ArgumentError,"Argument must be a String")
            end
        end
    end

end