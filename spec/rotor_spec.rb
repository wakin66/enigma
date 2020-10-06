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
                expect {Rotor.new(6)}.to raise_error(ArgumentError,"Invalid rotor.")
            end

            it "sets @notch to 16 if given rotor number I" do
                expect(Rotor.new(1).notch).to eq(16)
            end
        end

        context "is given an argument that is NOT an integer" do
            it "raises an error" do
                expect {Rotor.new("one")}.to raise_error(ArgumentError,"Invalid rotor.")
            end
        end
    end

    describe "#get_value" do
        context "is given a string as an argument" do
            it "doesn't raise an argument when length = 1" do
                expect {rotor.get_value("a",:forward)}.to_not raise_error
            end

            it "raises an error when length != 1" do
                expect {rotor.get_value("ab",:forward)}.to raise_error(ArgumentError,"Invalid character.")
            end

            it "raises an error when the string is not a letter" do
                expect {rotor.get_value("1",:forward)}.to raise_error(ArgumentError,"Invalid character.")
            end
        end

        context "is given an argument that is NOT a string" do
            it "raises an error" do
                expect {rotor.get_value(1,:forward)}.to raise_error(TypeError,"Character must be a String.")
            end
        end

        context "when going :forward" do
            context "when at the starting position" do
                it "returns 'E' when given the string 'A'" do
                    expect(rotor.get_value("A",:forward)).to eq("E")
                end

                it "returns 'C' when given the string 'Y'" do
                    expect(rotor.get_value("Y",:forward)).to eq("C")
                end
            end

            context "when rotated once" do
                it "returns 'J' when given the string 'A'" do
                    rotor.rotate_forward
                    expect(rotor.get_value("A",:forward)).to eq("J")
                end

                it "returns 'I' when given the string 'Y'" do
                    rotor.rotate_forward
                    expect(rotor.get_value("Y",:forward)).to eq("I")
                end
            end
        end

        context "when going :backward" do
            context "when at the starting position" do
                it "returns 'A' when given the string 'E'" do
                    expect(rotor.get_value("E",:backward)).to eq("A")
                end

                it "returns 'Y' when given the string 'C'" do
                    expect(rotor.get_value("C",:backward)).to eq("Y")
                end
            end

            context "when rotated once" do
                it "returns 'V' when given the string 'A'" do
                    rotor.rotate_forward
                    expect(rotor.get_value("A",:backward)).to eq("V")
                end

                it "returns 'I' when given the string 'Y'" do
                    rotor.rotate_forward
                    expect(rotor.get_value("Y",:backward)).to eq("I")
                end
            end
        end
    end

    describe "#window" do
        it "returns a String" do
            expect(rotor.window).to be_an(String)
        end

        it "returns 'A' if no position is specified" do
            expect(Rotor.new(1).window).to eq("A")
        end

        it "returns 'F' if a position argument of 5 is given" do
            expect(Rotor.new(1,5).window).to eq("F")
        end
    end

    describe "#rotate_forward" do
        context "when the current position is < 26" do
            let (:new_rotor) {Rotor.new(1)}
            it "changes the position to 1" do
                expect(new_rotor.rotate_forward).to eq(1)
            end
        end

        context "when the current position is == 25" do
            let (:new_rotor) {Rotor.new(1,25)}
            it "changes the position to 0" do
                expect(new_rotor.rotate_forward).to eq(0)
            end
        end
    end

    describe "#rotate_backward" do
        context "when the current position is < 26" do
            let (:new_rotor) {Rotor.new(1,10)}
            it "changes the position to 9" do
                expect(new_rotor.rotate_backward).to eq(9)
            end
        end

        context "when the current position is == 0" do
            let (:new_rotor) {Rotor.new(1)}
            it "changes the position to 25" do
                expect(new_rotor.rotate_backward).to eq(25)
            end
        end
    end

end