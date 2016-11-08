require "apollo/bot/version"
require "active_support/dependencies"
require "httmultiparty"

module Apollo
  module Bot

    autoload :Classifier, "apollo/bot/classifier"

    # Username for authentication
    mattr_accessor :username
    @@username = nil

    # Password for authentication
    mattr_accessor :password
    @@password = nil

    # Method to set the authentication keys for the bot
    def self.configure
      yield self
    end
  end
end

require "apollo/bot/errors"
