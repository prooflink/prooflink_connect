require 'cgi'

module ProoflinkConnect
  autoload :Configuration, "prooflink_connect/configuration"
  autoload :Assertion, "prooflink_connect/assertion"
  autoload :PortableContacts, "prooflink_connect/portable_contacts"
  autoload :ShareButton, "prooflink_connect/share_button"
  autoload :Invite, "prooflink_connect/invite"
  autoload :Share, "prooflink_connect/share"
  autoload :Activity, "prooflink_connect/activity"

  def self.config
    @configuration ||= Configuration.new
  end

  def self.configure
    yield config
  end

  def self.embedded(options = {}, config = ProoflinkConnect.config)
    # needed because you didn't have to use px explicitly in the old situation
    [:width, :height].each do |dimension|
      next if options[dimension].nil?
      value = options[dimension].to_s
      if !value.match(/[%|px]/)
        options[dimension] = value << "px"
      end
    end

    options = {
      :subdomain => config.subdomain,
      :token_url => 'https://example.com/auth/callbacks',
      :forced_connect => false,
      :embed_forms => false, # will be deprecated
      :split_screen => false,
      :use_popups => true,
      :register_flow => false,
      :width => '520px',
      :height => '250px'}.merge(options)

    domain_part = [options[:subdomain], config.provider_endpoint].compact.join(".")
    path_part = [options[:locale], 'authentications', 'embedded'].compact.join("/")
    query_part = "token_url=#{options[:token_url]}"
    query_part << "&forced_connect=1" if options[:forced_connect]
    query_part << "&embed_forms=1" if options[:embed_forms]
    query_part << "&split_screen=1" if options[:split_screen]
    query_part << "&use_popups=1" if options[:use_popups]
    query_part << "&show_header=#{options[:show_header] ? 1 : 0}" if !options[:show_header].nil?
    query_part << "&register_flow=1" if options[:register_flow]
    query_part << "&scenario=#{options[:scenario]}" if options[:scenario]
    frame_url = "#{config.protocol}://#{domain_part}/#{path_part}?#{query_part}"
    html = "<iframe src='#{frame_url}' style='width: #{options[:width]}; height: #{options[:height]}; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    html.respond_to?(:html_safe) ? html.html_safe : html
  end
end
