$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'test/unit'
require 'fluent/test'
require 'fluent/test/helpers'
require 'fluent/test/driver/parser'
require 'fluent/plugin/parser_monolog'

Test::Unit::AutoRunner.need_auto_run = false if defined?(Test::Unit::AutoRunner)
