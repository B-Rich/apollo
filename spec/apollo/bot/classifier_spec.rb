require 'spec_helper'
require 'date'
describe Apollo::Bot::Classifier do

  before(:each) do
    @classifier = Apollo::Bot::Classifier.new({ "classifier_id" => 1,
                                                "url"       => "http://url.example",
                                                "name"      => "Some Name",
                                                "language"  => "English",
                                                "status"    => "Available",
                                                "created"   => "December 09, 2011"})
  end

  context "when status is 'Available" do
    before { @classifier.status = "Available"}
    describe "#available?" do
      it "should return true" do
        expect(@classifier.available?).to be true
      end
    end
    describe "#unavailable?"do
      it "should return false" do
        expect(@classifier.unavailable?).to be false
      end
    end
    describe "#non_existent?"do
      it "should return false" do
        expect(@classifier.non_existent?).to be false
      end
    end
    describe "#non_existent?"do
      it "should return false" do
        expect(@classifier.non_existent?).to be false
      end
    end
  end

context "when status is 'Unavailable" do
    before { @classifier.status = "Unavailable"}
    describe "#available?" do
      it "should return false" do
        expect(@classifier.available?).to be false
      end
    end
    describe "#unavailable?"do
      it "should return true" do
        expect(@classifier.unavailable?).to be true
      end
    end
    describe "#non_existent?"do
      it "should return false" do
        expect(@classifier.unavailable?).to be false
      end
    end
    describe "#non_existent?"do
      it "should return false" do
        expect(@classifier.unavailable?).to be false
      end
    end
  end

end
