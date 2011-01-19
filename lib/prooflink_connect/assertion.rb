module ProoflinkConnect
  class Assertion
    attr_accessor :token

    def initialize(token)
      @token = token
    end

    def request_auth_info
      url = URI.parse("#{ProoflinkConnect.config.protocol}://#{[ProoflinkConnect.config.subdomain, ProoflinkConnect.config.provider_endpoint].compact.join(".")}/client_assertions/auth_info/")
      # query = partial_query.dup
      query = {}
      query['format'] = 'json'
      query['token'] = @token
      query['api_key'] = ProoflinkConnect.config.api_key

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
          raise AuthinfoException.new(resp), 'Unable to parse JSON response' + resp.body.inspect
        end
      else
        raise AuthinfoException, "Unexpected HTTP status code from server: #{resp.code}"
      end
    end

    def auth_info
      return PortableContacts::Person.new(request_auth_info['entry'])
    end

    class AuthinfoException < ::StandardError
    end
  end
end