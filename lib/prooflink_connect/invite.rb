require 'httparty'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/hash/reverse_merge'
require 'multi_json'

class ProoflinkConnect::Invite
  attr_reader :configuration, :attributes
  attr_accessor :locale

  def initialize(attributes, configuration = ProoflinkConnect.config)
    @attributes = attributes.stringify_keys
    @configuration = configuration
  end

  def save(params = {})
    return false if created?

    uri = configuration.base_uri + "/invites"
    params.reverse_merge! "invite" => attributes, "api_key" =>  configuration.api_key, "locale" => locale || 'nl'

    response = HTTParty.post(uri, :body => params)

    if response.code == 200
      self.attributes.merge! MultiJson.load(response.body)["entry"].stringify_keys
    end

    return created?
  end

  def url
    attributes["invite_url"] if created?
  end

  def person
    @person ||= ProoflinkConnect::PortableContacts::Person.new(attributes)
  end

  private

  def created?
    !!attributes["id"]
  end
end
