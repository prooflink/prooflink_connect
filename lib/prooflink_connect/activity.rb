require 'oauth2'

module ProoflinkConnect
  class Activity

    # POST /api/v2/activities
    # parameters:
    # - activity (required) => {:activity_type => {:identifier => "some_identifier", :name => "Some name", :value => "1"}}
    # - user => {:email => "foo@bar.com", :first_name => "Foo", :last_name => "Bar"} [for new user]
    # - user_token => "123-456-789" [for existing user]
    # - extra_info (optional) => {} [extra custom info you like to pass to activity]

    # SAMPLE:

    # ProoflinkConnect::Activity.log({
    #     activity_type: {identifier: 'some_identifier', name: 'some_name', value: '1'},
    #     user: {first_name: 'jon', last_name: 'doe', email: 'jon@doe.com', identity_provider: 'prooflink'},
    #     extra_info: {your_id: '1234'}
    # })

    def self.log(params)
      oauth_access_token = ProoflinkConnect.config.oauth_access_token
      client             = OAuth2::Client.new(nil, nil, {:site => ProoflinkConnect.config.base_uri})
      access_token       = OAuth2::AccessToken.new(client, oauth_access_token, :header_format => "OAuth %s")

      access_token.post 'api/v2/activities', :body => {:activity => params}
    end
  end
end