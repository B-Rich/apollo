[![Build Status](https://travis-ci.org/IcaliaLabs/apollo.svg?branch=master)](https://travis-ci.org/IcaliaLabs/apollo)
[![Code Climate](https://codeclimate.com/github/IcaliaLabs/apollo/badges/gpa.svg)](https://codeclimate.com/github/IcaliaLabs/apollo)
[![Test Coverage](https://codeclimate.com/github/IcaliaLabs/apollo/badges/coverage.svg)](https://codeclimate.com/github/IcaliaLabs/apollo/coverage)
[![Issue Count](https://codeclimate.com/github/IcaliaLabs/apollo/badges/issue_count.svg)](https://codeclimate.com/github/IcaliaLabs/apollo)
# Apollo::Bot

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/apollo/bot`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

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

In order for Apollo to work correctly, it is important that you set up an IBM Bluemix account of your own and that your trial period hasn't ended (or, for that matter, that you've registered for a paid account)

First add the following block to your application's configuration file:

```ruby
Apollo::Bot.configure do |config|
	config.username = SOME_USERNAME
	config.password = SOME_PASSWORD
	config.base_uri = "https://gateway.watsonplatform.net/natural-language-classifier/api"
end
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/apollo-bot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

