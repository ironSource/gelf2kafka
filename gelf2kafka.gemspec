lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "gelf2kafka/version"
 
Gem::Specification.new do |s|
  s.name        = "gelf2kafka"
  s.version     = Gelf2Kafka::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alexander Piavlo"]
  s.email       = ["devops@supersonic.com"]
  s.homepage    = "http://github.com/SupersonicAds/gelf2kafka"
  s.summary     = "Gelf deamon what sends events to kafka"
  s.description = "Gelf deamon what sends events to kafka"
  s.license     = 'MIT'
  s.has_rdoc    = false

  s.add_dependency('gelfd')
  s.add_dependency('poseidon')
  s.add_dependency('snappy')
  s.add_dependency('hash_symbolizer')
  s.add_dependency('schash')
  s.add_dependency('timers')
  s.add_dependency('activesupport', '~> 4.2.6')

  s.add_development_dependency('rake')

  s.files         = Dir.glob("{bin,lib}/**/*") + %w(gelf2kafka.gemspec LICENSE README.md)
  s.executables   = Dir.glob('bin/**/*').map { |file| File.basename(file) }
  s.test_files    = nil
  s.require_paths = ['lib']
end
