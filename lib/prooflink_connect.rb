module ProoflinkConnect
  autoload :Configuration, "prooflink_connect/configuration"
  autoload :Assertion, "prooflink_connect/assertion"
  autoload :PortableContacts, "prooflink_connect/portable_contacts"

  def self.config
    Configuration.instance
  end

  def self.configure
    yield config
  end

  def self.embedded(options = {})
    options = {:subdomain => ProoflinkConnect.config.subdomain, :token_url => 'https://example.com/auth/callbacks'}.merge(options)

    if options[:forced_connect]
      "<iframe src='#{ProoflinkConnect.config.protocol}://#{[options[:subdomain], ProoflinkConnect.config.provider_endpoint].compact.join(".")}/authentications/embedded?token_url=#{options[:token_url]}&forced_connect=1' style='width: 500px; height: 220px; border: 0;display: block' ></iframe>".html_safe
    else
      "<iframe src='#{ProoflinkConnect.config.protocol}://#{[options[:subdomain], ProoflinkConnect.config.provider_endpoint].compact.join(".")}/authentications/embedded?token_url=#{options[:token_url]}' style='width: 500px; height: 220px; border: 0;display: block' ></iframe>".html_safe
    end
  end
end
