# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'vcloud/disk_launcher/version'

Gem::Specification.new do |s|
  s.name        = 'vcloud-disk_launcher'
  s.version     = Vcloud::DiskLauncher::VERSION
  s.authors     = ['Mike Pountney']
  s.email       = ['Mike.Pountney@gmail.com']
  s.summary     = 'Tool to launch and configure vCloud Independent Disks'
  s.description = 'Tool to launch and configure vCloud Independent Disks. Uses vcloud-core.'
  s.homepage    = 'http://github.com/alphagov/vcloud-disk_launcher'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) {|f| File.basename(f)}
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.3'

  s.add_runtime_dependency 'vcloud-core', '~> 0.15.0'
  s.add_development_dependency 'gem_publisher', '1.2.0'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 2.14.1'
  s.add_development_dependency 'rubocop', '~> 0.23.0'
  # Pin SimpleCov to < 0.8.x until this issue is resolved:
  # https://github.com/colszowka/simplecov/issues/281
  s.add_development_dependency 'simplecov', '~> 0.7.1'
  s.add_development_dependency 'vcloud-tools-tester', '~> 0.3.0'
end

