require 'spec_helper'

describe ProoflinkConnect::Activity do
  before do
    reset_configuration
  end

  it "should log activity as expected" do
    stub_request(:post, "https://example.prooflink.com/api/v2/activities").
      with(:body => {"activity"=>{"activity_type"=>{"name"=>"My name", "value"=>"1", "identifier"=>"my_identifier"}, "user"=>{"identity_provider"=>"prooflink", "email"=>"jon@doe.com"}}}, :headers => {'Accept'=>'*/*', 'Authorization'=>'OAuth 4321', 'Content-Type'=>'application/x-www-form-urlencoded'}).
      to_return(:status => 200, :body => MultiJson.encode({"status"=>"SUCCESS", "message"=>"activity succesfully created"}), :headers => {})
    params = {:activity_type => {:identifier => "my_identifier", :name => "My name", :value => 1},
              :user => {:email => "jon@doe.com", :identity_provider => 'prooflink'}}

    ProoflinkConnect::Activity.log(params).should eq({"status"=>"SUCCESS", "message"=>"activity succesfully created"})
  end

  it "rescues OAuth2::Error exceptions" do
    stub_request(:post, "https://example.prooflink.com/api/v2/activities").
      with(:body => "", :headers => {'Accept'=>'*/*', 'Authorization'=>'OAuth 4321', 'Content-Type'=>'application/x-www-form-urlencoded'}).
      to_return(:status => 406, :body => MultiJson.encode({"status"=>"ERROR", "message"=>"no activity specified"}), :headers => {})
    ProoflinkConnect::Activity.log({}).should eq({"status"=>"ERROR", "message"=>"no activity specified"})
  end

  it "new user" do
    stub_request(:post, "https://example.prooflink.com/api/v2/activities").
      with(:body => {"activity" => {"activity_type" => {"identifier" => "follow", "name" => "Following", "value" => "1"}, "user" => {"identity_provider" => "prooflink", "email" => "jon@doe.com"}}}).
      to_return(:status => 200, :body => MultiJson.encode({"status" => "SUCCESS", "message" => "activity succesfully created"}), :headers => {})
    user = {:email => "jon@doe.com", :identity_provider => 'prooflink'}
    options = {:activity_name => "Following", :activity_value => 1}
    ProoflinkConnect::Activity.track("follow", user, options)
  end

  it "existing user" do
    stub_request(:post, "https://example.prooflink.com/api/v2/activities").
      with(:body => {"activity" => {"activity_type" => {"identifier" => "follow", "name" => "Following", "value" => "1"}, "user" => {"identifier" => "12345"}}}).
      to_return(:status => 200, :body => MultiJson.encode({"status" => "SUCCESS", "message" => "activity succesfully created"}), :headers => {})
    options = {:activity_name => "Following", :activity_value => 1}
    ProoflinkConnect::Activity.track("follow", "12345", options)
  end

  it "allows disabling of activity tracking" do
    ProoflinkConnect.config.enable_activity_tracking = false
    ProoflinkConnect::Activity.should_not_receive(:build_request)
    ProoflinkConnect::Activity.track("follow", "12345")
  end
end

