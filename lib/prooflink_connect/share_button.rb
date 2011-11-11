module ProoflinkConnect
  class ShareButton
    attr_accessor :message
    attr_accessor :options

    def initialize(message = nil, options = {})
      @message = message
      @options = options
    end

    def to_html
      html = "<iframe src='#{ProoflinkConnect.config.protocol}://#{[ProoflinkConnect.config.subdomain, ProoflinkConnect.config.provider_endpoint].compact.join(".")}/#{@options[:locale]||"en"}/shares/button?message=#{CGI.escape @message}' style='width: 112px; height: 16px; border: 0;display: block' frameborder='0' scrolling='no'></iframe>"
      html.respond_to?(:html_safe) ? html.html_safe : html
    end
  end
end