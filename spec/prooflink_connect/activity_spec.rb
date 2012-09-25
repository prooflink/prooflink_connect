require 'spec_helper'

describe ProoflinkConnect::Activity do
  before do
    reset_configuration
  end

  before do
    stub_request(:post, "https://example.prooflink.com/api/v2/activities").
      with(:body => {"activity"=>{"activity_type"=>{"name"=>"My name", "value"=>"1", "identifier"=>"my_identifier"}, "user"=>{"identity_provider"=>"prooflink", "email"=>"jon@doe.com"}}}, :headers => {'Accept'=>'*/*', 'Authorization'=>'OAuth 4321', 'Content-Type'=>'application/x-www-form-urlencoded'}).
      to_return(:status => 200, :body => MultiJson.encode({"status"=>"SUCCESS", "message"=>"activity succesfully created"}), :headers => {})

    stub_request(:post, "https://example.prooflink.com/api/v2/activities").
      with(:body => "", :headers => {'Accept'=>'*/*', 'Authorization'=>'OAuth 4321', 'Content-Type'=>'application/x-www-form-urlencoded'}).
      to_return(:status => 406, :body => MultiJson.encode({"status"=>"ERROR", "message"=>"no activity specified"}), :headers => {})
  end

  it "should log activity as expected" do
    params = {:activity_type => {:identifier => "my_identifier", :name => "My name", :value => 1},
              :user => {:email => "jon@doe.com", :identity_provider => 'prooflink'}}

    ProoflinkConnect::Activity.log(params).should eq({"status"=>"SUCCESS", "message"=>"activity succesfully created"})

  end

  it "should not log activity when no params are passed" do
    ProoflinkConnect::Activity.log({}).should eq({"status"=>"ERROR", "message"=>"no activity specified"})
  end
end
