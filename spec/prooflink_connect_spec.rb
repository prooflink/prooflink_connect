require 'spec_helper'

describe ProoflinkConnect do
  it "returns iframe html with defaults" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&forced_connect=0&embed_forms=0' style='width: 520px; height: 250px; border: 0; display: block' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded.should == result
  end

  it "allows pixels or percentage for width" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&forced_connect=0&embed_forms=0' style='width: 100%; height: 250px; border: 0; display: block' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded({:width => "100%"}).should == result
  end

  it "adds px to width if not given" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&forced_connect=0&embed_forms=0' style='width: 100px; height: 250px; border: 0; display: block' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded({:width => "100"}).should == result
  end

  it "allows pixels or percentage for height" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&forced_connect=0&embed_forms=0' style='width: 520px; height: 100%; border: 0; display: block' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded({:height => "100%"}).should == result
  end

  it "adds px to height if not given" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&forced_connect=0&embed_forms=0' style='width: 520px; height: 100px; border: 0; display: block' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded({:height => "100"}).should == result
  end

  context "position" do
    it "query param" do
      result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&forced_connect=0&embed_forms=0&position=spec' style='width: 520px; height: 250px; border: 0; display: block' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect.embedded(:position => "spec").should == result
    end

    it "url encodes input" do
      result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&forced_connect=0&embed_forms=0&position=spec+with+spaces' style='width: 520px; height: 250px; border: 0; display: block' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect.embedded(:position => "spec with spaces").should == result
    end
  end
end
