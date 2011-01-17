module ProoflinkConnect
  class Configuration
    include Singleton

    @@defaults = {
      :provider_endpoint => "prooflink.local",
      :subdomain => "example",
      :protocol => "https"
    }

    def initialize
      @@defaults.each_pair{|k,v| self.send("#{k}=",v)}
    end

    attr_accessor :provider_endpoint, :subdomain, :api_key, :protocol
  end
end