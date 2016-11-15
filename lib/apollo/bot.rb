require "apollo/bot/version"
require "olimpo"

module Apollo
  module Bot
    extend Olimpo
    autoload :Classifier, "apollo/bot/classifier"
  end
end
