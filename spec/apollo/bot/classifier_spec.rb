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
    context "classification kind response" do
      before :each do
        @stub_classification = Apollo::Bot::Classification.new({"classifier_id"=>"10D41B-nlc-1",
                                                                "text"=>"How hot will it be today?",
                                                                "top_class"=>"temperature",
                                                                "classes"=>[{"class_name"=>"temperature",
                                                                             "confidence"=>0.9998201258549781},
                                                                             {"class_name"=>"conditions",
                                                                              "confidence"=>0.00017987414502176904}]})
        stub_response_classification = ExampleClassificationResponse.new

        allow(Apollo::Bot::Classifier).to receive(:get).and_return(stub_response_classification)
      end

      describe "#classify" do
        it "should return expected Classification instance" do
          classification = @classifier.classify("")

          expect(classification).to be_a_kind_of(Apollo::Bot::Classification)
          expect(classification.text).to be_eql(@stub_classification.text)
        end
      end

      describe ".classify" do
        it "should return expected Classification instance" do
          classification = @classifier.classify("")

          expect(classification).to be_a_kind_of(Apollo::Bot::Classification)
          expect(classification.text).to be_eql(@stub_classification.text)
        end
      end
    end

    context "classifier kind response" do
      before :each do
        @stub_response_classifier = ExampleClassifierResponse.new
        @stub_response_classifiers = ExampleClassifiersResponse.new
        @stub_response_create_classifier = ExampleCreateClassifierResponse.new

        allow(Apollo::Bot::Classifier).to receive(:get).and_return(@stub_response_classifier)
        allow(Apollo::Bot::Classifier).to receive(:delete).and_return({})
        allow(Apollo::Bot::Classifier).to receive(:post).and_return(@stub_response_create_classifier)
      end
      describe ".find" do
        it "should return information about a classifier" do
          classifier = Apollo::Bot::Classifier.find("10D41B-nlc-1")

          expect(@stub_response_classifier.success?).to be_eql(true)
          expect(classifier).to be_a_kind_of(Apollo::Bot::Classifier)
          expect(classifier.name).to be_eql("My Classifier")
        end
      end

      describe ".destroy" do
        it "should return an empty array" do
          classifier = Apollo::Bot::Classifier.delete("10D41B-nlc-1")

          expect(classifier).to be_empty
        end
      end

      describe ".all" do
        before :each do
          allow(Apollo::Bot::Classifier).to receive(:get).and_return(@stub_response_classifiers)
        end

        it "should return a list of classifiers" do
          classifier = Apollo::Bot::Classifier.all()
          first_classifier = classifier.first

          expect(@stub_response_classifiers.success?).to be_eql(true)
          expect(classifier.count).to be_eql(1)
          expect(first_classifier.id).to be_eql("10D41B-nlc-1")
        end
      end

      describe ".create" do
        it "should return information about the new classifier" do
          new_classifier = Apollo::Bot::Classifier.create("training_data"     => 1,
                                                      "training_metadata" => {"language" => "en",
                                                                               "name" => "My Classifier"})
          expect(@stub_response_create_classifier.success?).to be_eql(true)
          expect(new_classifier).to be_a_kind_of(Apollo::Bot::Classifier)
          expect(new_classifier.name).to be_eql("My Classifier")
          expect(new_classifier.status).to be_eql("Training")
        end
      end
    end
  end

  class ExampleClassificationResponse
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

  class ExampleClassifierResponse
    def success?
      true
    end

    def body
      {
        "classifier_id": "10D41B-nlc-1",
        "name": "My Classifier",
        "language": "en",
        "created": "2015-05-28T18:01:57.393Z",
        "url": "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/10D41B-nlc-1",
        "status": "Available",
        "status_description": "The classifier instance is now available and is ready to take classifier requests.",
      }.to_json
    end
  end

  class ExampleClassifiersResponse
    def success?
      true
    end

    def body
      {
        "classifiers": [
          {
            "classifier_id": "10D41B-nlc-1",
            "url": "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/10D41B-nlc-1",
            "name": "My Classifier",
            "language": "en",
            "created": "2015-05-28T18:01:57.393Z"
          }
        ]
      }.to_json
    end
  end

  class ExampleCreateClassifierResponse
    def success?
      true
    end

    def body
      {
        "classifier_id": "10D41B-nlc-1",
        "name": "My Classifier",
        "language": "en",
        "created": "2015-05-28T18:01:57.393Z",
        "url": "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/10D41B-nlc-1",
        "status": "Training",
        "status_description": "The classifier instance is in its training phase, not yet ready to accept classify requests"
      }.to_json
    end
  end
end
