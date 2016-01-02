$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "gelf2kafka/version"
 
task :build do
  system "gem build gelf2kafka.gemspec"
end
 
task :release => :build do
  system "gem push gelf2kafka-#{Gelf2Kafka::VERSION}.gem"
end
