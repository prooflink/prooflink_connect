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

  it "passes position parameters" do
    expected_parameters = {"format"=>["json"], "api_key"=>["1234"], "message"=>["This is pretty awesome"], "transaction"=>["pl2"], "position" => ["frontpage"]}
    stub_request(:post, "https://example.prooflink.com/shares/post_share_transaction").
      with{|request| expected_parameters == CGI.parse(request.body)}.
      to_return(:status => 200, :body => "", :headers => {})
    ProoflinkConnect::Share.post("pl2", "This is pretty awesome", "frontpage")
  end

  context "sharing iframe" do
    it "generates necessary html" do
      result = "<iframe src='https://example.prooflink.com/en/shares/embedded/new?message=placeholder' style='width: 400px; height: 355px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect::Share.embedded(:message => "placeholder").should == result
    end

    it "allows setting width and height" do
      result = "<iframe src='https://example.prooflink.com/en/shares/embedded/new?message=placeholder' style='width: 100%; height: 200px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect::Share.embedded(:message => "placeholder", :width => "100%", :height => "200px").should == result
    end

    it "adds the position query param" do
      result = "<iframe src='https://example.prooflink.com/en/shares/embedded/new?message=placeholder&position=spec' style='width: 400px; height: 355px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect::Share.embedded(:message => "placeholder", :position => "spec").should == result
    end

    it "url encodes position" do
      result = "<iframe src='https://example.prooflink.com/en/shares/embedded/new?message=placeholder&position=spec+with+spaces' style='width: 400px; height: 355px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect::Share.embedded(:message => "placeholder", :position => "spec with spaces").should == result
    end

    it "url encodes message" do
      result = "<iframe src='https://example.prooflink.com/en/shares/embedded/new?message=placeholder+with+spaces' style='width: 400px; height: 355px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect::Share.embedded(:message => "placeholder with spaces").should == result
    end

    it "uses correct locale" do
      ProoflinkConnect.configure do |config|
        config.locale = "nl"
      end
      result = "<iframe src='https://example.prooflink.com/nl/shares/embedded/new?message=placeholder' style='width: 400px; height: 355px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect::Share.embedded(:message => "placeholder").should == result
    end

    it "allows passing in locale" do
      result = "<iframe src='https://example.prooflink.com/nl/shares/embedded/new?message=placeholder' style='width: 400px; height: 355px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect::Share.embedded(:message => "placeholder", :locale => "nl").should == result
    end
  end
end
