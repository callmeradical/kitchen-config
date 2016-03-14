# Primary module for this gem, uses method missing to read shared config file.
require 'kitchen/config/version'

module Kitchen
  module Config
    require 'yaml'

    @config = nil

    def self.method_missing(method_sym, *_arguments, &_block)
      if @config.nil?
        self.load_config(ENV['KITCHEN_CONFIG'])
      end

      if @config.keys.include?(method_sym)
        @config[method_sym]
      else
        raise 'Undefined method or variable, '\
              "received #{method_sym}, availabile #{@config.keys}"
      end
    end

    def self.load_config(file)
      begin
        @config_path = File.expand_path(File.dirname(file))
      rescue ArguementError => e
        puts "You provided #{ENV['KITCHEN_CONFIG']}"
        raise 'Please define valid KITCHEN_CONFIG in your shell.'
      end
      @config = YAML.load_file("#{@config_path}/config.yml")
    end

    def self.respond_to?(method_sym, include_private = false)
      @config.keys.include?(method_sym) ? true : super
    end

    def self.tags(cb_name, user)
      "  tags:\n" \
      "    Name: \"Chef Tester\"\n" \
      "    Apps: \"#{cb_name} cookbook test\"\n" \
      "    App Owner: \"#{user}\""
    end
  end
end
