require 'spec_helper'

describe ProoflinkConnect::Configuration do
  it "provides defaults" do
    ProoflinkConnect.config.base_uri.should == "https://example.prooflink.com"
  end

  it "returns correct url" do
    ProoflinkConnect.configure do |config|
      config.provider_endpoint = "local-prooflink.com"
      config.subdomain = "testing"
      config.protocol = "http"
    end
    ProoflinkConnect.config.base_uri.should == "http://testing.local-prooflink.com"
  end

  it "sets locale" do
    ProoflinkConnect.configure do |config|
      config.locale = "en"
    end
    ProoflinkConnect.config.locale.should == "en"
  end
end

