require 'httparty'
require "active_support/core_ext/hash/keys"

class ProoflinkConnect::Invite
  attr_reader :configuration, :attributes
  attr_accessor :locale

  def initialize(attributes, configuration = ProoflinkConnect.config)
    @attributes = attributes.stringify_keys
    @configuration = configuration
  end

  def save
    uri = configuration.base_uri + "/invites"
    params = { "invite" => attributes, "api_key" =>  configuration.api_key, "locale" => locale || 'nl' }
    response = HTTParty.post(uri, :body => params)

    if response.headers["status"] == "200"
      self.attributes.merge! JSON.parse(response.body)["entry"].stringify_keys
    end

    return !attributes["id"].nil?
  end

  def person
    ProoflinkConnect::PortableContacts::Person.new(attributes)
  end
end
