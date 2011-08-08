require 'spec_helper'

describe ProoflinkConnect::Share do
  before do
    ProoflinkConnect.configure do |config|
      config.api_key = "1234"
    end
  end

  it "posts a message to Prooflink" do
    stub_request(:post, "https://example.prooflink.com/shares/post_share_transaction").
      with(:body => "format=json&api_key=1234&message=This%20is%20pretty%20awesome&transaction=pl1").
      to_return(:status => 200, :body => "", :headers => {})
    ProoflinkConnect::Share.post("pl1", "This is pretty awesome")
  end
end
