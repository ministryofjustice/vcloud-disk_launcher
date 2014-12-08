source 'https://rubygems.org'

gemspec

if ENV['VCLOUD_TOOLS_TESTER_DEV_MASTER']
  gem 'vcloud-tools-tester', :git => 'git@github.com:gds-operations/vcloud-tools-tester.git', :branch => 'master'
elsif ENV['VCLOUD_TOOLS_TESTER_LOCAL']
  gem 'vcloud-tools-tester', :path => '../vcloud-tools-tester'
end

if ENV['VCLOUD_CORE_DEV_MASTER']
  gem 'vcloud-core', :git => 'git@github.com:gds-operations/vcloud-core.git', :branch => 'master'
elsif ENV['VCLOUD_CORE_DEV_LOCAL']
  gem 'vcloud-core', :path => '../vcloud-core'
end
