class ProoflinkConnect::Invite < ActiveResource::Base
  class << self
    attr_accessor :api_key

    def site
      URI.parse("#{ProoflinkConnect.config.protocol}://#{ProoflinkConnect.config.subdomain}.#{ProoflinkConnect.config.provider_endpoint}/")
    end

    def api_key
      ProoflinkConnect.config.api_key
    end
  end

  attr_accessor :locale

  self.site = self.site
  self.element_name = 'invite'
  self.format = :json

  def person
    ProoflinkConnect::PortableContacts::Person.new(self.entry.attributes)
  end

  def save
    prefix_options[:api_key] = self.class.api_key
    prefix_options[:locale] = self.locale||"nl"
    super
  end
end