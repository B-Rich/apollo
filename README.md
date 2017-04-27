[![Build Status](https://travis-ci.org/IcaliaLabs/apollo.svg?branch=master)](https://travis-ci.org/IcaliaLabs/apollo)
[![Code Climate](https://codeclimate.com/github/IcaliaLabs/apollo/badges/gpa.svg)](https://codeclimate.com/github/IcaliaLabs/apollo)
[![Test Coverage](https://codeclimate.com/github/IcaliaLabs/apollo/badges/coverage.svg)](https://codeclimate.com/github/IcaliaLabs/apollo/coverage)
[![Issue Count](https://codeclimate.com/github/IcaliaLabs/apollo/badges/issue_count.svg)](https://codeclimate.com/github/IcaliaLabs/apollo)
# Apollo::Bot

Apollo is an open source ruby gem that acts as a wrapper for IBM Watson's [Natural
Language Classifier
service](https://www.ibm.com/watson/developercloud/nl-classifier.html)
API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apollo-bot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apollo-bot

## Usage


### Configuration

In order for Apollo to work correctly, it is important that you set up an IBM Bluemix account of your own and that your trial period hasn't ended (or, for that matter, that you've registered for a paid account)

First require the `apollo-bot` in your file:

```ruby
require 'apollo-bot'
```

Then add the following configuration block:

```ruby

Apollo::Bot.configure do |config|
	config.username = SOME_USERNAME
	config.password = SOME_PASSWORD
	config.base_uri = "https://gateway.watsonplatform.net/natural-language-classifier/api"
end
```

**Note: The username and password are not your Bluemix credentials. These
credentials are specific to the Natural Language Classifier API and must
be obtained from said section of Watson's Docs**

### Creating a new Classifier

In order to create a new classifier, simply use the `Apollo::Bot::Classifier` class' create method:

```ruby
Apollo::Bot::Classifier.create(training_data: SOME_DATA, 
                               training_metadata: { language: SOME_LANGUAGE,
                                                    name: "Example Bot"})

```

[Check Watson's API reference](https://www.ibm.com/watson/developercloud/natural-language-classifier/api/v1/#create_classifier) for details on how to use your own data in order to create a classifier.

### Using an Existing Classifier

In order to use an existing Classifier, simply use `Apollo::Bot::Classifier`'s find method:

```ruby
Apollo::Bot::Classifier.find(SOME_CLASSIFIER_ID)
```

All that is needed in order to execute the query is the classifier's unique id (such as "10D41B-nlc-1"). [Check Watson's API reference](https://www.ibm.com/watson/developercloud/natural-language-classifier/api/v1/#get_status) for more on getting information about an existing classifier.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/apollo-bot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).



