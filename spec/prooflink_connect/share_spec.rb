require 'spec_helper'

describe ProoflinkConnect::Share do
  before do
    reset_configuration
  end

  it "posts a message to Prooflink" do
    expected_parameters = {"format"=>["json"], "api_key"=>["1234"], "message"=>["This is pretty awesome"], "transaction"=>["pl2"]}
    stub_request(:post, "https://example.prooflink.com/shares/post_share_transaction").
      with{|request| expected_parameters == CGI.parse(request.body)}.
      to_return(:status => 200, :body => "", :headers => {})
    ProoflinkConnect::Share.post("pl2", "This is pretty awesome")
  end
end
