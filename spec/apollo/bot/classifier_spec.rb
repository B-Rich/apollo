require 'spec_helper'
require 'date'
describe Apollo::Bot::Classifier do

  before :each do
    @classifier = Apollo::Bot::Classifier.new({ "classifier_id" => 1,
                                      "url"       => "http://url.example",
                                      "name"      => "Some Name",
                                      "language"  => "English",
                                      "status"    => "Available",
                                      "created"   => "December 09, 2011"})
  end

  describe "boolean methods" do
    context "when status is 'Available" do
      before { @classifier.status = "Available"}
      describe "#available?" do
        expect(@classifier.available?).to be true
      end
    end
  end

end
