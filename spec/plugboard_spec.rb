require 'plugboard'

describe Plugboard do

    describe "#initialize" do
        it "creates @plugs as a Hash"

        it "fills @plugs with 28 keys"

        it "creates @unused_cables as the Integer 10"
    end

    describe "#add_cable" do
        context "when there is at least one unused cable" do
            context "and is called correctly" do
                it "takes two Strings as arguments"

                it "updates the two keys given with eachother as the value {:x => :y,:y => :x}"
            end

            context "and is not called correctly" do

                it "raises an error if only one String is given"

                it "raises an error if more than two Strings are given"

                it "raises an error if something other than a String is given"

                it "raises an error if an Argument has a length other than 1"
            end
        end

        context "when there are no unused cables" do
            it "raises an error"
        end
    end

    describe "#remove_cable" do
        context "when there is at least one used cable" do

        end

        context "when there are no used cables" do
            it "raises an error"
        end
    end

    describe "#get_pairs" do
        it "returns an array"
    end

    describe "#get_value" do
        context "when given a String as an argument" do

        end

        context "when the given argument is NOT a String" do

        end
    end

end