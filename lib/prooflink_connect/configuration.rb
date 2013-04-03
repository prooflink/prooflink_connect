require 'singleton'

module ProoflinkConnect
  class Configuration

    @@defaults = {
      :provider_endpoint => "prooflink.com",
      :subdomain => "example",
      :protocol => "https",
      :locale => "en"
    }

    def initialize
      @@defaults.each_pair{|k,v| self.send("#{k}=",v)}
    end

    attr_accessor :provider_endpoint, :subdomain, :api_key, :protocol, :locale, :oauth_access_token, :enable_activity_tracking

    def validate!
      raise InvalidConfigurationError if [:provider_endpoint, :subdomain, :api_key, :protocol].any?{|option|send(option).blank?}
    end

    def base_uri
      "#{protocol}://#{[subdomain, provider_endpoint].compact.join(".")}"
    end

    class InvalidConfigurationError < ::StandardError
    end
  end
end
