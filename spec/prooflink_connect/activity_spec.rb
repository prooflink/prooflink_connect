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
          {:body => {:status => "ERROR", :message => "no activity specified"}.to_json}
        else
          {:body => {:status => "SUCCESS", :message => "activity succesfully created"}.to_json}
        end
      end
  end

  it "should log activity as expected" do
    params = {:activity_type => {:identifier => "my_identifier", :name => "My name", :value => 1},
              :user => {:email => "jon@doe.com", :identity_provider => 'prooflink'}}

    ProoflinkConnect::Activity.log(params).should eq({"status"=>"SUCCESS", "message"=>"activity succesfully created"})
    ProoflinkConnect::Activity.log({}).should eq({"status"=>"ERROR", "message"=>"no activity specified"})
  end
end