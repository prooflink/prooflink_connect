require 'oauth2'

module ProoflinkConnect
  class Activity
    def self.track(identifier, user, options = {})
      activity = build_request(identifier, user, options)
      response = access_token.post('api/v2/activities', :body => {:activity => activity})
      MultiJson.decode(response.body)
    rescue OAuth2::Error => error
      MultiJson.decode(error.response.body)
    end

    def self.log(params)
      warn "Activity.log() is deprecated. Please use Activity.track() instead."

      response = access_token.post('api/v2/activities', :body => {:activity => params})
      MultiJson.decode(response.body)
    rescue OAuth2::Error => error
      MultiJson.decode(error.response.body)
    end

    private

    def self.build_request(identifier, user, options)
      activity = {:activity_type => {:identifier => identifier}}
      activity[:activity_type][:name] = options[:activity_name] if options[:activity_name]
      activity[:activity_type][:value] = options[:activity_value] if options[:activity_value]
      activity[:extra_info] = options[:extra_info] if options[:extra_info]

      if user.is_a?(Hash)
        activity.merge!({:user => user})
      else
        activity.merge!({:user_token => user})
      end

      activity
    end

    def self.access_token
      @access_token ||= begin
        oauth_access_token = ProoflinkConnect.config.oauth_access_token
        client = OAuth2::Client.new(nil, nil, {:site => ProoflinkConnect.config.base_uri})
        access_token = OAuth2::AccessToken.new(client, oauth_access_token, :header_format => "OAuth %s")
      end
    end
  end
end

