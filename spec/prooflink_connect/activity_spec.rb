require 'spec_helper'

describe ProoflinkConnect::Activity do
  before do
    reset_configuration
  end

  before do
    stub_request(:post, "https://example.prooflink.com/api/v2/activities").
      with(:headers => {'Accept'=>'*/*', 'Authorization'=>'OAuth 4321', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby'}).
      to_return do |request|
        if request.body.empty?
          {:status => 422, :body => "Error"}
        else
          {:status => 200, :body => ""}
        end
      end
  end

  it "should log activity as expected" do
    params = {:activity_type => {:identifier => "my_identifier", :name => "My name", :value => 1},
              :user => {:email => "jon@doe.com", :identity_provider => 'prooflink'}}
    ProoflinkConnect::Activity.log(params).status.should == 200
    lambda{ ProoflinkConnect::Activity.log({}).status.should == 422 }.should raise_error OAuth2::Error
  end
end