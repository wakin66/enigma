require 'plugboard'

describe Plugboard do
    subject(:plugboard) {Plugboard.new}

    # describe "#initialize" do
    #     it "creates @plugs as a Hash" do
    #         expect(plugboard.plugs).to be_a(Hash)
    #     end

    #     it "fills @plugs with 28 keys"

    #     it "creates @unused_cables as the Integer 10"
    # end

    describe "#add_cable" do
        context "when there is at least one unused cable" do
            context "and is called correctly" do
                it "takes two Strings as arguments" do
                    expect {plugboard.add_cable("a","y")}.to_not raise_error
                end

                it "returns the new key_value pairs {:x => :y,:y => :x}" do
                    expect(plugboard.add_cable("a","y")).to eq({"a"=>"y", "y"=>"a"})
                end
            end

            context "and is not called correctly" do

                it "raises an error if only one String is given" do
                    expect {plugboard.add_cable("a")}.to raise_error(ArgumentError, "wrong number of arguments (given 1, expected 2)")
                end

                it "raises an error if more than two Strings are given" do
                    expect {plugboard.add_cable("a","b","c")}.to raise_error(ArgumentError, "wrong number of arguments (given 3, expected 2)")
                end

                it "raises an error if something other than a String is given" do
                    expect {plugboard.add_cable("a","y")}.to raise_error(ArgumentError,"Arguments must be Strings")
                end

                it "raises an error if an Argument length != 1" do
                    expect {plugboard.add_cable("ab","y")}.to raise_error(ArgumentError,"Arguments must be a single letter")
                end
            end
        end

        context "when there are no unused cables" do
            it "raises an error" do
                plugboard.add_cable("a","b")
                plugboard.add_cable("c","d")
                plugboard.add_cable("e","f")
                plugboard.add_cable("g","h")
                plugboard.add_cable("i","j")
                plugboard.add_cable("k","l")
                plugboard.add_cable("m","n")
                plugboard.add_cable("o","p")
                plugboard.add_cable("q","r")
                plugboard.add_cable("s","t")
                expect {plugboard.add_cable("y","z")}.to raise_error(RuntimeError,"All wires are being used")
            end
        end
    end

    describe "#remove_cable" do
        context "when there is at least one used cable" do
            context "and it is called correctly" do
                it "takes an Integer as an argument" do
                    plugboard.add_cable("a","b")
                    expect {plugboard.remove_cable(1)}.to_not raise_error
                end
            end

            context "and it is not called correctly" do
                it "raises an error if the wire is empty" do
                    plugboard.add_cable("a","b")
                    expect {plugboard.remove_cable(5)}.to raise_error(RuntimeError,"That wire is not being used")
                end

                it "raises an error if the Integer is not between 1 and 10 inclusive" do
                    plugboard.add_cable("a","b")
                    expect {plugboard.remove_cable(15)}.to raise_error(ArgumentError,"That wire number does not exist")
                end
            end
        end

        context "when there are no used cables" do
            it "raises an error" do
                expect {plugboard.remove_cable(1)}.to raise_error(RuntimeError,"There are no wires currently being used")
            end
        end
    end

    describe "#get_wires" do
        it "returns an array" do
            expect(plugboard.get_wires).to be_an(Array)
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