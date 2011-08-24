require 'httparty'

module ProoflinkConnect
  class Share
    def self.post(transaction, message)
      uri = ProoflinkConnect.config.base_uri + "/shares/post_share_transaction"
      api_key = ProoflinkConnect.config.api_key
      params = {"api_key" => api_key, "transaction" => transaction,
        "message" => message, "format" => "json"}
      response = HTTParty.post(uri, :body => params)
    end

    def self.embedded(options = {}, config = ProoflinkConnect.config)
      options = {
        :width => "400px",
        :height => "355px"
      }.merge(options)

      src = "#{config.base_uri}/en/shares/embedded/new?message=#{options[:message]}"
      src << "&position=#{CGI.escape(options[:position])}" if options[:position]
      styling = "width: #{options[:width]}; height: #{options[:height]};"
      html = "<iframe src='#{src}' style='#{styling}'></iframe>"
      html.respond_to?(:html_safe) ? html.html_safe : html
    end
  end
end
