#
# the chef client cookbook utilizes a windows only lib called WIN32OLE.  This is
# all fine and dandy and all, but breaks when we fauxhai our chefspec run as
# a windows machine... you know... since WIN32OLE is ONLY available to windows
# versions of ruby.  So, to get around that, we're going to stub out this
# nastiness:

# btw... this is a stunning show of hacknery.
module WIN32OLE
  #This just accepts everything.
  module Stuby
    def self.ExecQuery(_args)
      WIN32OLE::Eachy
    end
  end
  
  # Iterative.
  module Eachy
    def self.each
      []
    end
  end

  def self.connect(_args)
    WIN32OLE::Stuby
  end
end

module Win32
  include WIN32OLE
end
