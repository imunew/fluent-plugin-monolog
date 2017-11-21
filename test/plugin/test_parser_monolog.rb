require_relative '../helper'
require 'fluent/test/driver/parser'
require 'fluent/test/helpers'
require 'fluent/plugin/parser_monolog'
require 'json'

include Fluent::Test::Helpers

class MonologParserTest < ::Test::Unit::TestCase
  def setup
    Fluent::Test.setup
    @parser = Fluent::Test::Driver::Parser.new(Fluent::Plugin::MonologParser)
    @expected = {
        'channel' => 'example',
        'context' => JSON.parse("{\"message\":\"foo bar\"}"),
        'extra'   => JSON.parse("[]"),
        'level'   => 'DEBUG',
        'message' => 'stream'
    }
  end

  def test_parse
    @parser.instance.parse('[2016-07-06 15:21:21] example.DEBUG: stream {"message":"foo bar"} []') { |time, record|
      assert_equal(event_time('2016-07-06 15:21:21', format: '%Y-%m-%d %H:%M:%S'), time)
      assert_equal(@expected, record)
    }
    assert_equal(Fluent::Plugin::MonologParser::REGEXP,
                 @parser.instance.patterns['format'])
    assert_equal(Fluent::Plugin::MonologParser::TIME_FORMAT,
                 @parser.instance.patterns['time_format'])
  end
end
