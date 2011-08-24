require 'cgi'

module ProoflinkConnect
  autoload :Configuration, "prooflink_connect/configuration"
  autoload :Assertion, "prooflink_connect/assertion"
  autoload :PortableContacts, "prooflink_connect/portable_contacts"
  autoload :ShareButton, "prooflink_connect/share_button"
  autoload :Invite, "prooflink_connect/invite"
  autoload :Share, "prooflink_connect/share"

  def self.config
    @configuration ||= Configuration.new
  end

  def self.configure
    yield config
  end

  def self.embedded(options = {}, config = ProoflinkConnect.config)
    # needed because you didn't have to use px explicitly in the old situation
    [:width, :height].each do |dimension|
      if options[dimension] && !options[dimension].include?("%")
        options[dimension] << "px"
      end
    end

    options = {
      :subdomain => config.subdomain,
      :token_url => 'https://example.com/auth/callbacks',
      :forced_connect => '0',
      :embed_forms => '0',
      :width => '520px',
      :height => '250px'}.merge(options)

    domain_part = [options[:subdomain], config.provider_endpoint].compact.join(".")
    path_part = [options[:locale], 'authentications', 'embedded'].compact.join("/")
    query_part = "token_url=#{options[:token_url]}&forced_connect=#{options[:forced_connect]}&embed_forms=#{options[:embed_forms]}"
    query_part << "&position=#{CGI.escape(options[:position])}" if options[:position]
    frame_url = "#{config.protocol}://#{domain_part}/#{path_part}?#{query_part}"
    html = "<iframe src='#{frame_url}' style='width: #{options[:width]}; height: #{options[:height]}; border: 0; display: block' frameborder='0' allowTransparency='true'></iframe>"
    html.respond_to?(:html_safe) ? html.html_safe : html
  end
end
