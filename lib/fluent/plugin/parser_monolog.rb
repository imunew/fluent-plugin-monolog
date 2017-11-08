require 'fluent/plugin/parser'
require 'json'

module Fluent
  module Plugin
    class TextParser
      class MonologParser < Parser
        Fluent::Plugin.register_parser('monolog', self)

        REGEXP = /^\[(?<time>[\d\-]+ [\d\:]+)\] (?<channel>.+)\.(?<level>(DEBUG|INFO|NOTICE|WARNING|ERROR|CRITICAL|ALERT|EMERGENCY))\: (?<message>[^\{\}]*) (?<context>(\{.+\})|(\[.*\])) (?<extra>(\{.+\})|(\[.*\]))\s*$/
        TIME_FORMAT = "%Y-%m-%d %H:%M:%S"

        def initialize
          super
          @time_parser = TimeParser.new(TIME_FORMAT)
          @mutex = Mutex.new
        end

        def patterns
          {'format' => REGEXP, 'time_format' => TIME_FORMAT}
        end

        def parse(text)
          m = REGEXP.match(text)
          unless m
            yield nil, nil
            return
          end

          time = m['time']
          time = @mutex.synchronize { @time_parser.parse(time) }

          channel = m['channel']
          level = m['level']
          message = m['message']
          context = JSON.parse(m['context'])
          extra = JSON.parse(m['extra'])

          record = {
              "channel" => channel,
              "level" => level,
              "message" => message,
              "context" => context,
              "extra" => extra
          }
          record["time"] = m['time'] if @keep_time_key

          yield time, record
        end
      end
    end
  end
end
