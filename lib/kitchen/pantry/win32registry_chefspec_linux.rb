#
# the windows cookbooks that we write utilize a windows only lib called Registry.
# WHen running chefspec on a windows box this does not present a problem, however
# since we develop on linux, we had to monkey patch the lib because chef does not
# load the lib on non-windows systems.
module Win32
  module Registry
    module Regmock
      def self.open(_a = nil, _b = nil)
        true
      end
    end

    HKEY_LOCAL_MACHINE = Regmock
    HKEY_USERS         = Regmock
    HKEY_CURRENT_USER  = Regmock
    KEY_ALL_ACCESS     = 0x000000

    def self.get_value(_a = nil, _b = nil)
      'super_string'
    end
  end
end
