module ProoflinkConnect
  autoload :Configuration, "prooflink_connect/configuration"
  autoload :Assertion, "prooflink_connect/assertion"
  autoload :PortableContacts, "prooflink_connect/portable_contacts"
  autoload :ShareButton, "prooflink_connect/share_button"
  autoload :Invite, "prooflink_connect/invite"

  def self.config
    Configuration.instance
  end

  def self.configure
    yield config
  end

  def self.embedded(options = {})
    options = {
      :subdomain => ProoflinkConnect.config.subdomain,
      :token_url => 'https://example.com/auth/callbacks',
      :forced_connect => '0',
      :embed_forms => '0',
      :width => 520,
      :height => 250}.merge(options)
    domain_part = [options[:subdomain], ProoflinkConnect.config.provider_endpoint].compact.join(".")
    path_part = [options[:locale], 'authentications', 'embedded'].compact.join("/")
    query_part = "token_url=#{options[:token_url]}&forced_connect=#{options[:forced_connect]}&embed_forms=#{options[:embed_forms]}"
    frame_url = "#{ProoflinkConnect.config.protocol}://#{domain_part}/#{path_part}?#{query_part}"
    "<iframe src='#{frame_url}' style='width: #{options[:width]}px; height: #{options[:height]}px; border: 0;display: block' frameborder='0' allowTransparency='true'></iframe>".html_safe
  end
end
