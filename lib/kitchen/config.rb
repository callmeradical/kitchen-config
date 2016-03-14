require 'kitchen/config/version'

module Kitchen
  module Config
    Config_path = File.expand_path(File.dirname(__FILE__))

    require 'yaml'
    @config = YAML.load_file("#{Config_path}/config.yml")

    def self.method_missing(method_sym, *_arguments, &_block)
      if @config.keys.include?(method_sym)
        @config[method_sym]
      else
        raise 'Undefined method or variable, '\
              "received #{method_sym}, availabile #{@config.keys}"
      end
    end

    def self.security_group_ids_yml
      Kernel.warn('[DEPRECATION] security_group_ids_yml, '\
                 'has been deprecated, calling security_group_ids')
      security_group_ids
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
