begin
  require 'rubygems'
  require 'bundler/setup'
  require 'json'

  require_relative 'ruby_runner'

  runner = RubyRunner.new
  runner.execute(:code => ARGV.first)
  puts runner.to_json
rescue Exception => ex
  puts ex.message
  raise ex
end

