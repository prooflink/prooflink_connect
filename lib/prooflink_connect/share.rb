require 'httparty'

module ProoflinkConnect
  class Share
    def self.post(transaction, message)
      uri = ProoflinkConnect.config.base_uri + "/shares/post_share_transaction"
      api_key = ProoflinkConnect.config.api_key
      params = {"api_key" => api_key, "transaction" => transaction,
        "message" => message, "format" => "json"}
      response = HTTParty.post(uri, :body => params)
    end
  end
end
