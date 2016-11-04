module Apollo
  module Bot
    class Classifier
      include HTTParty
      base_uri "https://gateway.watsonplatform.net/natural-language-classifier/api"

      attr_reader :id, :url, :name, :language, :created, :raw

      def initialize(attrs = {})
        @id = attrs[:classifier_id]
        @url = attrs[:url]
        @name = attrs[:name]
        @language = attrs[:language]
        @created = Date.parse(attrs[:created])
        @raw = attrs
      end

      def self.all
        #curl -u "{username}":"{password}" "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers"
        response = get("/v1/classifiers", basic_auth)
        parsed_response  = JSON.parse(response.body)

        parsed_response["classifiers"].map do |attrs|
          new(attrs)
        end
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
