require 'spec_helper'

describe ProoflinkConnect do
  it "returns iframe html with defaults" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 520px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded.should == result
  end

  it "allows pixels or percentage for width" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 100%; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded({:width => "100%"}).should == result
  end

  it "adds px to width if not given" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 100px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded({:width => "100"}).should == result
  end

  it "allows pixels or percentage for height" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 520px; height: 100%; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded({:height => "100%"}).should == result
  end

  it "adds px to height if not given" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 520px; height: 100px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded({:height => "100"}).should == result
  end

  it "sets split screen option" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&embed_forms=1&split_screen=1&use_popups=1' style='width: 520px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded(:split_screen => true, :embed_forms => true).should == result
  end

  it "sets use_popups option" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 520px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded(:use_popups => true).should == result
  end
end
