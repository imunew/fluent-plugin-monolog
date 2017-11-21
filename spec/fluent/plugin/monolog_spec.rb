require 'spec_helper'

describe Fluent::Plugin::MonologParser do
  include Fluent::Test::Helpers

  before(:all) do
    @parser = Fluent::Test::Driver::Parser.new(Fluent::Plugin::MonologParser)
  end

  it 'parse monolog' do
    text = <<-MONOLOG
[2016-07-06 11:54:23] default.INFO: User registered {"username":"gabrieloliverio"} {"data":"Hello world!"}
MONOLOG
    time = record = nil
    @parser.instance.parse(text) do |t, r|
      time = t
      record = r
    end
    expect(event_time('2016-07-06 11:54:23')).to eq(time)
    expect(record['channel']).to eq('default')
    expect(record['level']).to eq('INFO')
    expect(record['message']).to eq('User registered')
    expect(record['context']).to eq({"username"=>"gabrieloliverio"})
    expect(record['extra']).to eq({"data"=>"Hello world!"})
  end
end
