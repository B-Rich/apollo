module Apollo
  module Bot
    class Classifier
      include HTTMultiParty
      base_uri "https://gateway.watsonplatform.net/natural-language-classifier/api"
      basic_auth Apollo::Bot.username, Apollo::Bot.password
      headers 'Content-Type' => 'application/json'
      debug_output $stdout

      attr_reader :id, :url, :name, :language, :created, :raw

      def initialize(attrs = {})
        @id = attrs["classifier_id"]
        @url = attrs["url"]
        @name = attrs["name"]
        @language = attrs["language"]
        @status = attrs["status"]
        @created = Date.parse(attrs["created"])
        @raw = attrs
      end

      def available?
        status == "Available"
      end

      def unavailable?
        !available?
      end

      def non_existent?
        status == "Non Existent"
      end

      def training?
        status == "Traning"
      end

      def self.find(id)
        response = get("/v1/classifiers/#{id}", basic_auth)
        parsed_response  = JSON.parse(response.body)

        return new(parsed_response) if response.success?
        response
      end

      def self.all
        #curl -u "{username}":"{password}" "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers"
        response = get("/v1/classifiers", basic_auth)
        parsed_response  = JSON.parse(response.body)

        parsed_response["classifiers"].map do |attrs|
          new(attrs)
        end
      end

      def self.create(attrs = {})
        #Apollo::Bot::Classifier.create(training_data: File.open("file.csv"), training_metadata: { language: "en", name: "IcaliaBot"}.to_json)
        response = post("/v1/classifiers", basic_auth.merge({body: attrs}))
        parsed_response  = JSON.parse(response.body)

        return new(parsed_response) if response.success?
        response
      end

      class << self

        def basic_auth
          {
            basic_auth: {
              username: Apollo::Bot.username,
              password: Apollo::Bot.password
            }
          }
        end
      end
    end
  end
end
