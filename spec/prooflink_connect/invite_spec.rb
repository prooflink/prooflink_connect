require 'spec_helper'

describe ProoflinkConnect::Invite do
  before do
    reset_configuration
  end

  it "creates a Prooflink invite" do
    attributes = {:email => 'newuser@prooflink.com'}

    stub_request(:post, "https://example.prooflink.com/invites").
      with(:body => "invite[email]=newuser%40prooflink.com&api_key=1234&locale=nl").
      to_return(:status => 200, :body => {
        "entry" => {
          "name" => {},
          "displayName" => "Prooflink",
          "id" => "cg6a1Turx70NWzkkwrbGRDRvImY=\n",
          "invite_url" => "url"
        }
      }.to_json, :headers => {})

    invite = ProoflinkConnect::Invite.new(attributes)
    invite.save.should == true
    invite.save.should == false
  end

  it "creates a Prooflink invite with custom parameters" do
    attributes = {:email => 'newuser@prooflink.com'}
    expected_parameters = {"locale"=>["nl"], "api_key"=>["4567"], "invite[email]"=>["newuser@prooflink.com"]}

    stub_request(:post, "https://example.prooflink.com/invites").
      with{|request| expected_parameters == CGI.parse(request.body)}.
      to_return(:status => 200, :body => {
        "entry" => {
          "name" => {},
          "displayName" => "Prooflink",
          "id" => "cg6a1Turx70NWzkkwrbGRDRvImY=\n",
          "invite_url" => "url"
        }
      }.to_json, :headers => {})

    invite = ProoflinkConnect::Invite.new(attributes)
    invite.save({"api_key" => "4567"}).should == true
  end

end

