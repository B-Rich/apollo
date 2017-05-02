[![Build Status](https://travis-ci.org/IcaliaLabs/apollo.svg?branch=master)](https://travis-ci.org/IcaliaLabs/apollo)
[![Code Climate](https://codeclimate.com/github/IcaliaLabs/apollo/badges/gpa.svg)](https://codeclimate.com/github/IcaliaLabs/apollo)
[![Test Coverage](https://codeclimate.com/github/IcaliaLabs/apollo/badges/coverage.svg)](https://codeclimate.com/github/IcaliaLabs/apollo/coverage)
[![Issue Count](https://codeclimate.com/github/IcaliaLabs/apollo/badges/issue_count.svg)](https://codeclimate.com/github/IcaliaLabs/apollo)

<div style="text-align:center">
  <img src="assets/logo.png" width="980">
</div>

Apollo is an open source ruby gem that acts as a wrapper for IBM Watson's [Natural
Language Classifier
service API](https://www.ibm.com/watson/developercloud/nl-classifier.html).

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

In order for Apollo to work correctly, it is important that you [set up an IBM Bluemix account of your own](https://console.ng.bluemix.net/) and that your trial period hasn't ended (or, for that matter, that you've registered for a paid account)

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

`Apollo::Bot::Classifier.create` returns an instance of `Apollo::Bot::Classifier` which corresponds to the newly created Natural Language Classifier. An example of said object can be seen below:

```
#<Apollo::Bot::Classifier:0x007f8dd907f120 @id="10D41B-nlc-1",
@url="https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/10D41B-nlc-1",
@name="My Classifier", @language="en", @status="Available", @created=#<Date: 2015-05-28 ((2457171j,0s,0n),+0s,2299161j)>,
@raw={"classifier_id"=>"10D41B-nlc-1", "name"=>"My Classifier", "language"=>"en", "created"=>"2015-05-28T18:01:57.393Z",
"url"=>"https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/10D41B-nlc-1",
"status"=>"Available", "status_description"=>"The classifier instance is now available and is ready to take classifier requests."}>
```

[Check Watson's API reference](https://www.ibm.com/watson/developercloud/natural-language-classifier/api/v1/#create_classifier) for details on how to use your own data in order to create a classifier.

### Finding an Existing Classifier

In order to use an existing Classifier, simply use `Apollo::Bot::Classifier`'s find method:

```ruby
Apollo::Bot::Classifier.find(SOME_CLASSIFIER_ID)
```

All that is needed in order to execute the query is the classifier's unique id (such as "10D41B-nlc-1").

`Apollo::Bot::Classifier.` also returns an instance of `Apollo::Bot::Classifier` which corresponds to an existing Natrual Language Classifier with the selected classfier id.


[Check Watson's API reference](https://www.ibm.com/watson/developercloud/natural-language-classifier/api/v1/#get_status) for more on getting information about an existing classifier.

### Getting all existing Classifiers

In order to get all existing Natural Language Classifiers:

```ruby
Apollo::Bot::Classifier.all
```
This method returns an array containing a new instances of `Apollo::Bot::Classifier` corresponding to every single existing Natural Language Classifier available through Watson's API.

### Deleting an Existing Classifier

In order to permanently delete an existing Natural Language
Classifier, simply use the `destroy` class method:

```ruby
Apollo::Bot::Classifier.destroy(SOME_CLASSIFIER_ID)
```

This method returns `true` if the Classifier was successfully destroyed through Watson's API and `false` otherwise.


### Classifying Text

The main focus of Watson's Natural Language Classifier is, of course, classifying text. Through `Apollo::Bot::Class`, there's two ways to classify text.

The first and main way is to use the `classify` class method.

```ruby
Apollo::Bot::Classifier.classify(SOME_CLASSIFIER_ID, SOME_TEXT)
```

This method takes an existing Classifier's id as well as the input text to be classified and returns an instance of `Apollo::Bot::Classification`. The classes under which the given text will be classified will be accessible under the object's `top_class` and `classes` attributes.

The second way of classifying text is through an existing instance of `Apollo::Bot::Classifier`. Simply call `classify` on the instance and send the text to be classified as a parameter.

```ruby
sample_classifier = Apollo::Bot::Classifier.find(SOME_CLASSIFIER_ID)
sample_classifier.classify(SOME_TEXT)
```

This method is actually called by the previously mentioned `classify` class method, so the return value is the same. 

For more information on how text is classified please consult [Watson's Natural Language Classifier API Reference](https://www.ibm.com/watson/developercloud/natural-language-classifier/api/v1/#classify).


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/IcaliaLabs/apollo-bot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).





