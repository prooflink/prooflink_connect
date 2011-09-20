require 'httparty'

module ProoflinkConnect
  class Share
    def self.post(transaction, message, position = nil)
      uri = ProoflinkConnect.config.base_uri + "/shares/post_share_transaction"
      api_key = ProoflinkConnect.config.api_key
      params = {"api_key" => api_key, "transaction" => transaction,
        "message" => message, "format" => "json"}
      params["position"] = position if position
      response = HTTParty.post(uri, :body => params)
    end

    def self.embedded(options = {}, config = ProoflinkConnect.config)
      options = {
        :width => "400px",
        :height => "355px",
        :locale => config.locale
      }.merge(options)

      src = "#{config.base_uri}/#{options[:locale]}/shares/embedded/new?message=#{CGI.escape(options[:message])}"
      src << "&position=#{CGI.escape(options[:position])}" if options[:position]
      styling = "width: #{options[:width]}; height: #{options[:height]};"
      styling << " border: 0; display: block;"
      default_options = "frameborder='0' allowTransparency='true'"
      html = "<iframe src='#{src}' style='#{styling}' #{default_options}></iframe>"
      html.respond_to?(:html_safe) ? html.html_safe : html
    end
  end
end
