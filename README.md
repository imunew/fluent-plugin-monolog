# Fluent::Plugin::Monolog

[![Build Status](https://travis-ci.org/imunew/fluent-plugin-monolog.svg?branch=master)](https://travis-ci.org/imunew/fluent-plugin-monolog)

Put your Ruby code in the file `lib/fluent/plugin/monolog`. 
To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Install via `td-agent-gem`.

```bash
$ td-agent-gem install fluent-plugin-monolog
```

We have an example for this plugin, so please use it.

- [fluent-plugin-monolog-example](https://github.com/imunew/fluent-plugin-monolog-example)

## Usage

After installed, please add configurations of [in_tail(tail Input Plugin)](https://docs.fluentd.org/v0.14/articles/in_tail) to `td-agent.conf`, like below.

```
# /etc/td-agent/td-agent.conf

<source>
  @type tail
  path /path/to/example.log
  format monolog
  pos_file /path/to/example.log.pos
  tag example.stream
</source>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/imunew/fluent-plugin-monolog. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

