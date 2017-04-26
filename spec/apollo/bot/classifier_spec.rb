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
  describe "boolean methods" do

    context "when status is 'Available'" do
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

    context "when status is 'Unavailable'" do
      before { @classifier.status = "Unavailable"}

      describe "#available?" do
        it "should return false" do
          expect(@classifier.available?).to be false
        end
      end
      describe "#unavailable?" do
        it "should return true" do
          expect(@classifier.unavailable?).to be true
        end
      end
      describe "#non_existent?" do
        it "should return false" do
          expect(@classifier.non_existent?).to be false
        end
      end
      describe "#training?" do
        it "should return false" do
          expect(@classifier.training?).to be false
        end
      end
    end

    context "when status is 'Non Existent'" do
      before { @classifier.status = "Non Existent"}

      describe "#available?" do
        it "should return false" do
          expect(@classifier.available?).to be false
        end
      end
      describe "#unavailable?" do
        it "should return false" do
          expect(@classifier.unavailable?).to be false
        end
      end
      describe "#non_existent?" do
        it "should return true" do
          expect(@classifier.non_existent?).to be true
        end
      end
      describe "#training?" do
        it "should return false" do
          expect(@classifier.training?).to be false
        end
      end
    end

    context "when status is 'Training'" do
      before { @classifier.status = "Training" }

      describe "#available?" do
        it "should return false" do
          expect(@classifier.available?).to be false
        end
      end
      describe "#unavailable?" do
        it "should return false" do
          expect(@classifier.unavailable?).to be false
        end
      end
      describe "#non_existent?" do
        it "should return false" do
          expect(@classifier.non_existent?).to be false
        end
      end
      describe "training?" do
        it "should return true" do
          expect(@classifier.training?).to be true
        end
      end
    end
  end

  describe "API Methods" do
    before :each do
      @stub_classification = Apollo::Bot::Classification.new({"classifier_id"=>"10D41B-nlc-1",
                                                              "text"=>"How hot will it be today?",
                                                              "top_class"=>"temperature",
                                                              "classes"=>[{"class_name"=>"temperature",
                                                                           "confidence"=>0.9998201258549781},
                                                                           {"class_name"=>"conditions",
                                                                            "confidence"=>0.00017987414502176904}]})

      stub_response = ExampleResponse.new
      allow(Apollo::Bot::Classifier).to receive(:get).and_return(stub_response)
    end

    describe "#classify" do
      it "should return expected Classification instance" do
        classification = @classifier.classify("")
        expect(classification).to be_a_kind_of(Apollo::Bot::Classification)
        expect(classification.text).to be_eql(@stub_classification.text)
      end
    end
  end

  class ExampleResponse
    def success?
      true
    end

    def body
      {
        "classifier_id": "10D41B-nlc-1",
        "url": "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/10D41B-nlc-1/classify?text=How%20hot%20wil/10D41B-nlc-1",
        "text": "How hot will it be today?",
        "top_class": "temperature",
        "classes": [
          {
            "class_name": "temperature",
            "confidence": 0.9998201258549781
          },
          {
            "class_name": "conditions",
            "confidence": 0.00017987414502176904
          }
        ]
      }.to_json
    end
  end
end
