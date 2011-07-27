require 'singleton'

module ProoflinkConnect
  class Configuration

    @@defaults = {
      :provider_endpoint => "prooflink.com",
      :subdomain => "example",
      :protocol => "https"
    }

    def initialize
      @@defaults.each_pair{|k,v| self.send("#{k}=",v)}
    end

    attr_accessor :provider_endpoint, :subdomain, :api_key, :protocol

    def validate!
      raise InvalidConfigurationError if [:provider_endpoint, :subdomain, :api_key, :protocol].any?{|option|send(option).blank?}
    end

    class InvalidConfigurationError < ::StandardError
    end
  end
end