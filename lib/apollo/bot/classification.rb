module Apollo
  module Bot
    class Classification

      class Class
        attr_reader :class_name, :confidence

        def initialize(attrs = {})
          @class_name = attrs["class_name"]
          @confidence = attrs["confidence"]
        end
      end

      attr_reader :classifier_id, :text, :top_class, :classes

      def initialize(attrs = {})
        @classifier_id = attrs["classifier_id"]
        @text = attrs["text"]
        @top_class = attrs["top_class"]
        @classes = attrs["classes"].map { |attrs| Apollo::Bot::Classification::Class.new(attrs) }
      end

      def classifier
        @classifier ||= Apollo::Bot::Classifier.find(classifier_id)
      end
    end
  end
end
