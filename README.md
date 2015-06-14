# Avrocado

[![Build Status](https://travis-ci.org/connexio-labs/avrocado.svg?branch=master)](https://travis-ci.org/connexio-labs/avrocado)
[![Code Climate](https://codeclimate.com/github/connexio-labs/avrocado/badges/gpa.svg)](https://codeclimate.com/github/connexio-labs/avrocado)
[![Coverage Status](https://coveralls.io/repos/connexio-labs/avrocado/badge.svg)](https://coveralls.io/r/connexio-labs/avrocado)
[![Gem Version](https://badge.fury.io/rb/avrocado.svg)](http://badge.fury.io/rb/avrocado)

Wraps the Java avro.jar with a more straightforward API.

## Installation

Because this library is a wrapper around the avro.jar it must be run with JRuby. Use the ruby installer (ie. [ruby-build](https://github.com/sstephenson/ruby-build)) of your choice before continuing.

Add this line to your application's Gemfile:

```ruby
gem 'avrocado'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install avrocado

## Usage

Serialize a hash to a byte array:

```ruby
message = {
  to: 'bill',
  from: 'jim',
  message: 'hello world'
}

bytes = Avrocado::Serializer.serialize(message)
```

Deserialize an encoded message:

```ruby
Avrocado::Deserializer.deserialize(bytes)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/connexio-labs/avrocado/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
