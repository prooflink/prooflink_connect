require 'cgi'

module ProoflinkConnect
  class Assertion
    require 'net/http'
    attr_reader :token

    def initialize(token)
      @token = token
    end

    def auth_info(configuration = ProoflinkConnect.config)
      PortableContacts::Person.new(request_auth_info(configuration)['entry'])
    end

    private

    def request_auth_info(configuration)
      configuration.validate!.inspect

      url = URI.parse(configuration.base_uri + "/client_assertions/auth_info/")
      query = {}
      query['format'] = 'json'
      query['token'] = token
      query['api_key'] = configuration.api_key

      http = Net::HTTP.new(url.host, url.port)

      if url.scheme == 'https'
        http.use_ssl = true
      end
      data = query.map { |k,v|
        "#{CGI::escape k.to_s}=#{CGI::escape v.to_s}"
      }.join('&')

      resp = http.post(url.path, data)
      if resp.code == '200'
        begin
          data = JSON.parse(resp.body)
        rescue JSON::ParserError => err
          raise AuthinfoException.new(resp), "Unable to parse JSON response: #{resp.body.inspect}"
        end
      else
        raise AuthinfoException, "Unexpected HTTP status code from server: #{resp.code}"
      end
    end

    class AuthinfoException < ::StandardError
    end
  end
end