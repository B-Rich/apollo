require "apollo/bot/classification"

module Apollo
  module Bot
    class Classifier
      include HTTMultiParty
      base_uri "https://gateway.watsonplatform.net/natural-language-classifier/api"
      basic_auth Apollo::Bot.username, Apollo::Bot.password
      headers 'Content-Type' => 'application/json'
      debug_output $stdout

      attr_reader :id, :url, :name, :language, :created, :status, :raw

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
        status == "Unavailable"
      end

      def non_existent?
        status == "Non Existent"
      end

      def training?
        status == "Training"
      end

      def classify(text)
        response = self.class.get("/v1/classifiers/#{id}/classify", query: { text: text })
        parsed_response  = JSON.parse(response.body)

        return Apollo::Bot::Classification.new(parsed_response) if response.success?
        self.class.raise_exception(response.code, response.body)
      end

      def self.classify(id, text)
        classifier = find(id)
        classifier.classify(text)
      end

      def self.find(id)
        response = get("/v1/classifiers/#{id}")
        parsed_response  = JSON.parse(response.body)

        return new(parsed_response) if response.success?
        raise_exception(response.code, response.body)
      end

      def self.destroy(id)
        response = delete("/v1/classifiers/#{id}")
        response.success?
      end

      def self.all
        response = get("/v1/classifiers")
        parsed_response  = JSON.parse(response.body)

        return parsed_response["classifiers"].map { |attrs| new(attrs) } if response.success?
        raise_exception(response.code, response.body)
      end

      def self.create(attrs = {})
        response = post("/v1/classifiers", body: attrs)
        parsed_response  = JSON.parse(response.body)

        return new(parsed_response) if response.success?
        raise_exception(response.code, response.body)
      end

      def self.raise_exception(code, body)
        raise Apollo::Bot::Error::ServerError.new(code, body) if code >= 500
        raise Apollo::Bot::Error::ClientError.new(code, body) if code < 500
      end
    end
  end
end
