[![Build Status](https://travis-ci.org/callmeradical/kitchen-config.svg?branch=master)](https://travis-ci.org/callmeradical/kitchen-config)
[![Code Climate](https://codeclimate.com/github/callmeradical/kitchen-config/badges/gpa.svg)](https://codeclimate.com/github/callmeradical/kitchen-config)
[![Test Coverage](https://codeclimate.com/github/callmeradical/kitchen-config/badges/coverage.svg)](https://codeclimate.com/github/callmeradical/kitchen-config/coverage)
# Kitchen::Config

Kitchen::Config handles initializing a new cookbook and provides an easy way to configure your kitchen.yml variables across all your projects.

## Usage

To use kitchen-config add this to your Gemfile:
```ruby
gem 'kitchen-config'
```

Once you have added this to your project you create a config.yml in the location of your choice and set an environment variable called KITCHEN_CONFIG.

```bash
$ mkdir ~/.kitchen
$ touch ~/.kitchen/config.yml
$ export KITCHEN_CONFIG=$HOME/.kitchen/config.yml
```



Once you have created the file and set your environment variable you can start creating keys in your config to standardize your config options.

Example config.yml



```yaml
---
:key_id: 'your_key_here'
:tester_ami: 'your_ami_here'
:tester_flavor_id: 'your_instance_size'
:region: 'your_region'

```



Once your kitchen-config is set-up you may now include kitchen-config in your .kitchen.yml file:

```yaml
<% require 'kitchen/config' %>
<% config = Kitchen::Config %>
<% user = "#{`git config --get user.name`.chomp}" %>
---
settings:
  parallel: true

driver:
  name: <%= config.driver %>
  require_chef_omnibus: <%= config.chef_version %>
  image_id: <%= config.amazon_ami %>
  aws_ssh_key_id: <%= config.key_id %>
  instance_type: '<%= config.tester_flavor_id %>'
  region: '<%= config.region %>'
  availability_zone: '<%= config.availability_zone %>'
  subnet_id: '<%= config.subnet_id %>'
  require_chef_omnibus: <%= config.chef_version %>
  iam_profile_name: '<%= config.iam_profile_name%>'
<%= config.tags 'kitchen_config_test', user %>

transport:
  ssh_key: <%= ENV['HOME'] %>/.ssh/<%= config.key_id %>.pem
  username: '<%= config.username %>'

provisioner:
  name: <%= config.provisioner %>

platforms:
  - name: <%= config.default_platform %>
  - name: rhel7
    driver:
      image_id: <%= config.rhel7_ami %>

suites:
  - name: default
    run_list:
      - recipe[kitchen_config_test::test]
```



