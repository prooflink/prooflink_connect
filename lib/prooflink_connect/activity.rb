require 'oauth2'

module ProoflinkConnect
  class Activity
    def self.track(identifier, user, options = {})
      return if !perform_request?

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
      activity[:user] = {:identity_provider => 'prooflink'}

      # In case of a new user that has no identifier yet
      if user.is_a?(Hash)
        activity[:user].merge!(user)
      else
        activity[:user][:identifier] = user
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

    def self.perform_request?
      if !ProoflinkConnect.config.enable_activity_tracking.nil?
        return ProoflinkConnect.config.enable_activity_tracking
      end
      return false if defined?(Rails) && !Rails.env.production?
      return false if ENV['RACK_ENV'] && ENV['RACK_ENV'] != "production"
      true
    end
  end
end

