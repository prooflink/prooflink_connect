module ProoflinkConnect
  class ShareButton
    attr_accessor :message
    attr_accessor :options

    def initialize(message = nil, options = {})
      @message = message
      @options = options
    end

    def to_html
      "<iframe src='#{ProoflinkConnect.config.protocol}://#{[ProoflinkConnect.config.subdomain, ProoflinkConnect.config.provider_endpoint].compact.join(".")}/#{@options[:locale]||"en"}/shares/button?message=#{CGI.escape @message}' style='width: 100px; height: 100px; border: 0;display: block' frameborder='0'></iframe>".html_safe
    end
  end
end