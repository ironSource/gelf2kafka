# Gelf2Kafka

Runs gelfd daemon that accepts felf events and pushes them to kafka.

## Installation

Install libsnappy dev libs if you want to take advantage of compression

    apt-get install libsnappy-dev

Add this line to your application's Gemfile:

    gem 'gelf2kafka'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install gelf2kafka

## Usage

    $ gelf2kafka -h
    Usage: gelf2kafka [options]
            --config PATH                Path to settings config
        -h, --help                       Display this screen
    $

## Config

    gelfd:
      host: localhost
      port: 11211
      flush_interval: 1
      max_batch_events: 1024
    kafka:
      brokers: ["broker1:9092", "broker2:9092", "broker3:9092"]
      producer_type: sync
      produce: true

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
6. Go to 1
