require 'spec_helper'

describe ProoflinkConnect do
  it "returns iframe html with defaults" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 520px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded.should == result
  end

  context "width" do
    it "allows integer" do
      result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 100px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect.embedded({:width => 100}).should == result
    end

    it "allows pixels" do
      result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 100%; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect.embedded({:width => "100%"}).should == result
    end

    it "allows percentage" do
      result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 100%; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect.embedded({:width => "100%"}).should == result
    end

    it "adds px if not given" do
      result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 100px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect.embedded({:width => "100"}).should == result
    end
  end

  context "height" do
    it "allows integer" do
      result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 520px; height: 100px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect.embedded({:height => 100}).should == result
    end

    it "allows pixels" do
      result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 520px; height: 300px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect.embedded({:height => "300px"}).should == result
    end

    it "allows percentage" do
      result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 520px; height: 100%; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect.embedded({:height => "100%"}).should == result
    end

    it "adds px if not given" do
      result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 520px; height: 100px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect.embedded({:height => "100"}).should == result
    end
  end

  it "sets split screen option" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&embed_forms=1&split_screen=1&use_popups=1' style='width: 520px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded(:split_screen => true, :embed_forms => true).should == result
  end

  it "sets use_popups option" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1' style='width: 520px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded(:use_popups => true).should == result
  end

  it "disables use_popups option" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks' style='width: 520px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded(:use_popups => false).should == result
  end

  it "enables show_header option" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1&show_header=1' style='width: 520px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded(:show_header => true).should == result
  end

  it "disables show_header option" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1&show_header=0' style='width: 520px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded(:show_header => false).should == result
  end

  it "sets register_flow option" do
    result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1&register_flow=1' style='width: 520px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
    ProoflinkConnect.embedded(:register_flow => true).should == result
  end

  context "scenario" do
    it "sets manual option" do
      result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1&scenario=manual' style='width: 520px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect.embedded(:scenario => "manual").should == result
    end

    it "sets social option" do
      result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1&scenario=social' style='width: 520px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect.embedded(:scenario => "social").should == result
    end

    it "sets split screen option" do
      result = "<iframe src='https://example.prooflink.com/authentications/embedded?token_url=https://example.com/auth/callbacks&use_popups=1&scenario=split_screen' style='width: 520px; height: 250px; border: 0; display: block;' frameborder='0' allowTransparency='true'></iframe>"
      ProoflinkConnect.embedded(:scenario => "split_screen").should == result
    end
  end
end
